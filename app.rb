# frozen_string_literal: true

require 'sinatra/base'
require_relative 'app/contexts/taipingshan_context'

class RecreationBookingApp < Sinatra::Base
  get '/' do
    # TODO: use guide
    'This is recreation booking'
  end

  get '/calendars/:location' do
    case params['location']
    when 'taipingshan'
      content_type :json
      TaipingshanContext.new(village: params[:village], room_type_id: params[:roomTypeId])
                        .perform
                        .dates_hash
                        .to_json
    else
      raise "The location #{params['location']} is not available."
    end
  end

  error 400 do
    "Bad request.#{env['sinatra.error'].message}"
  end

  error 404 do
    "Not found.#{env['sinatra.error'].message}"
  end

  error 500..599 do
    'Something went wrong!'
  end

  run! if app_file == $PROGRAM_NAME
end
