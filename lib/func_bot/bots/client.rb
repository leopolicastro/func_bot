# frozen_string_literal: true

module FuncBot
  module Bots
    class Client
      attr_accessor :bot

      def initialize(bot)
        @bot = bot
      end

      def call
        open_ai.chat(
          parameters: chat_params
        )
      end

      private

      def chat_params
        params = {
          model: "gpt-3.5-turbo-0613",
          messages: bot.history.payload,
          temperature: 0.7
        }
        params.merge!(function_params) if bot.include_functions
        params
      end

      def function_params
        {functions: FuncBot::Functions::List.call}
      end

      def open_ai
        @client ||= OpenAI::Client.new
      end
    end
  end
end
