# frozen_string_literal: true

require_relative 'lib/tai_ping_shan/crawler'

result = TaiPingShan::Crawler.instance.list_villages
puts result.status
puts result.body
