# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/config_file'
require 'redis-sinatra'
require_relative 'app/contexts/taipingshan_context'
require_relative 'app/contexts/taipingshan_info_context'

class RecreationBookingApp < Sinatra::Base
  register Sinatra::ConfigFile

  config_file 'config.yml'

  set :cache, Sinatra::Cache::RedisStore.new(settings.redis_url)

  get '/' do
    # TODO: use guide
    'This is recreation booking'
  end

  get '/infomation/taipingshan' do
    return TaipingshanInfoContext.get(village: params[:village], room_type_id: params[:room_type_id]).to_json
  end

  get '/calendars/taipingshan' do
    return halt 404 unless params[:village] && params[:room_type_id]

    context = TaipingshanContext.new(settings.cache, village: params[:village], room_type_id: params[:room_type_id])
    halt 404, 'No data is found' unless context

    content_type :json
    context.dates_array.to_json
  end

  run! if app_file == $PROGRAM_NAME
end
