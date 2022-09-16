# frozen_string_literal: true

require 'singleton'
require 'faraday'
require 'faraday-cookie_jar'

class Client
  HOST = 'https://tps.forest.gov.tw'

  def self.instance
    @instance ||= Faraday.new(url: HOST) do |faraday|
      faraday.request  :url_encoded
      faraday.adapter  Faraday.default_adapter
    end
  end
end
