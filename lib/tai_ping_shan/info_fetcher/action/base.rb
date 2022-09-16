# frozen_string_literal: true

require 'singleton'
require_relative '../client'

module TaiPingShan
  class InfoFetcher
    module Action
      class Base
        include ::Singleton

        private

        def client
          Client.instance
        end
      end
    end
  end
end
