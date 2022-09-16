# frozen_string_literal: true

require_relative 'info_fetcher/action/village'

module TaiPingShan
  class InfoFetcher
    include Singleton

    def list_villages
      http_response = Action::Village.instance.list
    end
  end
end
