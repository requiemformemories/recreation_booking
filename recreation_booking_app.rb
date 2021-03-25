# frozen_string_literal: true

require 'sinatra/base'
require_relative 'app/contexts/taipingshan_context'

class RecreationBookingApp < Sinatra::Base
  get '/' do
    # TODO: use guide
    'This is recreation booking'
  end

  get '/calendars/taipingshan' do
    return halt 404 unless params[:village] && params[:room_type_id]

    context = TaipingshanContext.new(village: params[:village], room_type_id: params[:room_type_id]).perform
    halt 404, 'No data is found' unless context

    content_type :json
    context.dates_array.to_json
  end

  run! if app_file == $PROGRAM_NAME
end
