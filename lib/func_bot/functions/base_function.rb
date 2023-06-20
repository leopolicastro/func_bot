# frozen_string_literal: true

module FuncBot
  module Functions
    class BaseFunction
      attr_reader :bot

      def initialize(bot)
        @bot = bot
      end

      def parsed_response
        JSON.parse(
          bot.response.dig("choices", 0, "message", "function_call", "arguments")
        )
      end
    end
  end
end
