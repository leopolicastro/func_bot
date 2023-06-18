# frozen_string_literal: true

module FuncBot
  module Chats
    class Handler
      class << self
        def call(response, history)
          history << {role: "assistant", content: dig_for_content(response)}
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
