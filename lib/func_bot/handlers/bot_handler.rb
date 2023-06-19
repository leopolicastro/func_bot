# frozen_string_literal: true

module FuncBot
  module Handlers
    class BotHandler
      class << self
        def call(response, history)
          history << Bots::Message.new("assistant", dig_for_content(response)).data
          dig_for_content(response)
        end

        private

        def dig_for_content(response)
          response.dig("choices", 0, "message", "content")
        end
      end
    end
  end
end
