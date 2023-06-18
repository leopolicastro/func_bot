# frozen_string_literal: true

module FuncBot
  module Bots
    class Client
      def self.call(messages)
        client.chat(
          parameters: {
            model: "gpt-3.5-turbo-0613",
            messages: messages,
            temperature: 0.7,
            functions: FuncBot::Functions::List.call
          }
        )
      end

      def self.client
        @client ||= OpenAI::Client.new
      end
    end
  end
end
