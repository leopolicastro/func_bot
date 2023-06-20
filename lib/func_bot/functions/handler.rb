# frozen_string_literal: true

module FuncBot
  module Functions
    class Handler
      attr_accessor :prompt, :bot

      def initialize(bot)
        @bot = bot
      end

      def handle
        bot.history.chronicle("function", function_data, function_name)
        bot.client.call
      end

      private

      def function_data
        constantize_function.new(bot).execute
      end

      def constantize_function
        "FuncBot::Functions::#{function_name}".constantize
      end

      def function_name
        bot.response.dig("choices", 0, "message", "function_call", "name")
      end

      def dig_for_content
        bot.response.dig("choices", 0, "message", "content")
      end
    end
  end
end
