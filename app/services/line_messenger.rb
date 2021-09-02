# frozen_string_literal: true

require 'line/bot'

class LineMessenger
  Response = Struct.new(:status, :body)

  def initialize(request, config:)
    @request = request
    @request_body = request.body.read
    @config = config
  end

  def present
    return Response.new(403, 'unauthorized') unless authorized?

    process_events

    Response.new(200, 'OK')
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_id = @config['channel_id']
      config.channel_secret = @config['channel_secret']
      config.channel_token = @config['chanel_token']
    end
  end

  def authorized?
    signature = @request.env['HTTP_X_LINE_SIGNATURE']
    client.validate_signature(@request_body, signature)
  end

  def process_events
    events = client.parse_events_from(@request_body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message then process_messages(event)
      end
    end
  end

  def process_messages(event)
    case event.type
    when Line::Bot::Event::MessageType::Text
      process_text_messages(event)
    end
  end

  def process_text_messages(event)
    text = case event.message['text']
           when '太平山房型' then '房型'
           when /太平山預訂/ then '預訂'
           when 'help', '幫助' then '施工中'
           else
             '沒有這個指令，透過「help」來看看怎麼使用吧'
           end

    message = { type: 'text', text: text }

    client.reply_message(event['replyToken'], message)
  end
end
