# frozen_string_literal: true

require 'singleton'
require 'faraday'
require 'faraday-cookie_jar'

class Client
  HOST = 'https://tpsr.forest.gov.tw/'

  def self.instance
    @instance ||= Faraday.new(url: HOST) do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter
      faraday.use :cookie_jar
      faraday.response :logger
    end
  end
end
