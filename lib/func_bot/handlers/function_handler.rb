# frozen_string_literal: true

module FuncBot
  module Handlers
    class FunctionHandler < BaseHandler
      attr_accessor :prompt, :bot, :response

      def initialize(response, bot)
        @response = response
        @bot = bot
      end

      def handle
        function_return = constantize_function.new(response).execute
        @response = respond_to(function_return)
        bot.history.messages << Bots::Message.new("assistant", dig_for_content).data
        dig_for_content
        # bot
      end

      def constantize_function
        "FuncBot::Functions::#{function_name}".constantize
      end

      def function_name
        response.dig("choices", 0, "message", "function_call", "name")
      end

      def respond_to(prompt)
        @prompt = prompt
        messages
        bot.client.call
      end

      def messages
        bot.history.messages << Bots::Message.new("function", prompt, function_name).data
      end
    end
  end
end
