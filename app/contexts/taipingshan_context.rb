# frozen_string_literal: true

require 'net/http'
require 'json'

class TaipingshanContext
  CALENDAR_PATH = 'https://tpsr.forest.gov.tw/TPSOrder/calendar'

  def initialize(village:, room_type_id:)
    @village = village
    @room_type_id = room_type_id
  end

  def perform
    res = Net::HTTP.post_form(URI(CALENDAR_PATH), village: @village, room_type_id: @room_type_id)
    res_body = res.body.force_encoding('UTF-8')
    @data = JSON.parse(res_body)
    self
  end

  def dates_hash
    raise 'Try to get dates hash without perform.' if @data.nil?

    array = []
    %w[thisMonth nextMonth nextTwoMonth].each do |month|
      @data[month]['array'].each do |row|
        next unless row.is_a?(Hash)
        next if row['url'].empty?

        array << row['url']
      end
    end

    array
  end
end
