require "openai"

require "func_bot/version"
require "func_bot/engine"

require_relative "func_bot/bots/client"
require_relative "func_bot/bots/history"
require_relative "func_bot/bots/message"
require_relative "func_bot/functions/base_function"
require_relative "func_bot/functions/list"
require_relative "func_bot/handlers/base_handler"
require_relative "func_bot/handlers/bot_handler"
require_relative "func_bot/handlers/function_handler"

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
