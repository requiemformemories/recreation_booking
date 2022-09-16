# frozen_string_literal: true

require_relative 'base'

module TaiPingShan
  class InfoFetcher
    module Action
      class Village < Base
        LIST_PATH = '/TPSWeb/wSite/lp?ctNode=368&mp=1&idPath=215_220_368' # 首頁 / 線上訂房 / 房型介紹

        def list
          client.get(LIST_PATH)
        end
      end
    end
  end
end
