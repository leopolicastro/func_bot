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
            messages: bot.history.payload,
            temperature: 0.7,
            functions: FuncBot::Functions::List.call(bot)
          }
        )
      end

      private

      def open_ai
        @client ||= OpenAI::Client.new
      end
    end
  end
end
