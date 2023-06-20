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
          parameters: {
            model: "gpt-3.5-turbo-0613",
            messages: bot.history.messages,
            temperature: 0.7,
            functions: function_list
          }
        )
      end

      private

      def function_list
        FuncBot::Functions::List.call
      end

      def open_ai
        @client ||= OpenAI::Client.new
      end
    end
  end
end
