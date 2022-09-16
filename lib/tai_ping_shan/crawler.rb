# frozen_string_literal: true

require_relative 'crawler/action'

module TaiPingShan
  class Crawler
    include Singleton

    def list_villages
      action.index
      # captcha_response1 = action.reload_captcha
      captcha_response1 = action.captcha_image
      captcha_response = action.answer_captcha
    end

    private

    def action
      Action.instance
    end
  end
end
