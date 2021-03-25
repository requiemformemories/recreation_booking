# frozen_string_literal: true

require 'yaml'

class TaipingshanInfoContext
  def self.get(village: nil, room_type_id: nil)
    return raw if village.nil? && room_type_id.nil?
    return raw[village] if room_type_id.nil?
    return raw[village]['rooms'][room_type_id.to_i] if raw[village]
  end

  def self.raw
    YAML.load_file('app/yamls/taipingshan_info.yml')
  end
end
