# frozen_string_literal: true

module FuncBot
  class Bot
    attr_reader :client, :history

    def initialize
      @history = Bots::History.new
      @client = Bots::Client.new(self)
    end

    def ask(prompt)
      history.chronicle("user", prompt)
      handle_response(call_openai)
    end

    private

    def call_openai
      client.call
    end

    def handle_response(response)
      if function_call?(response)
        Handlers::FunctionHandler.new(response, self).handle
      else
        Handlers::BotHandler.new(response, self).handle
      end
    end

    def function_call?(response)
      response.dig("choices", 0, "message", "function_call").present?
    end
  end
end
