# frozen_string_literal: true

require 'singleton'
require_relative 'client'

module TaiPingShan
  class Crawler
    class Action
      include Singleton

      INDEX_PATH = '/TPSOrder/wSite/index.do?action=indexPage'
      CAPTCHA_IMAGE_PATH = '/TPSOrder/wSite/stickyCaptcha.png'
      CAPTCHA_PATH = '/TPSOrder/CaptchaService'
      VILLAGE_LIST_PATH = '/TPSOrder/wSite/content.do'

      def index
        client.get(INDEX_PATH)
      end

      def captcha_image
        client.get(CAPTCHA_IMAGE_PATH)
      end

      def reload_captcha
        client.post(CAPTCHA_PATH, { method: 'remove' })
      end

      def answer_captcha
        client.post(CAPTCHA_PATH, { method: 'answer' })
      end

      def validate_captcha
        client.post(CAPTCHA_PATH, { method: 'valid', ans: '' })
      end

      def village_list
        client.get(VILLAGE_LIST_PATH)
      end

      private

      def client
        Client.instance
      end
    end
  end
end
