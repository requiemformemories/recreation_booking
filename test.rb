require_relative 'lib/tai_ping_shan/info_fetcher'

result = TaiPingShan::InfoFetcher.instance.list_villages
puts result.status
puts result.body
