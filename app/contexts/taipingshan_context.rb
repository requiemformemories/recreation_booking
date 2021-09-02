# frozen_string_literal: true

require 'net/http'
require 'json'

class TaipingshanContext
  CALENDAR_PATH = 'https://tpsr.forest.gov.tw/TPSOrder/calendar'
  MONTH_KEYS = %w[thisMonth nextMonth nextTwoMonth].freeze

  def initialize(cache, village:, room_type_id:)
    @cache = cache
    @village = village
    @room_type_id = room_type_id

    get_data
  end

  def dates_array
    raise 'Try to get dates hash without perform.' if @data.nil?

    array = []
    MONTH_KEYS.each do |month|
      @data[month]['array'].each do |row|
        next unless row.is_a?(Hash)
        next if row['url'].empty?

        array << row['url']
      end
    end

    array
  end

  private

  def get_data
    @data = @cache.fetch("taipingshan:#{@village}:#{@room_type_id}", expires_in: 60) { perform }
  end

  def perform_success?(data)
    (MONTH_KEYS - data.keys).empty?
  end

  def perform
    res = Net::HTTP.post_form(URI(CALENDAR_PATH), village: @village, roomTypeId: @room_type_id)
    res_body = res.body.force_encoding('UTF-8')
    data = JSON.parse(res_body)

    return nil unless perform_success?(data)

    data
  end
end
