require "openai"

require "func_bot/version"
require "func_bot/engine"

require_relative "func_bot/bots/client"
require_relative "func_bot/bots/history"
require_relative "func_bot/bots/message"
require_relative "func_bot/functions/base_function"
require_relative "func_bot/functions/handler"
require_relative "func_bot/functions/list"

module FuncBot
  class Bot
    attr_accessor :response, :include_functions
    attr_reader :client, :history

    def initialize
      @history = Bots::History.new
      @client = Bots::Client.new(self)
      @include_functions = true
    end

    def ask(prompt)
      history.chronicle("user", prompt)
      self.response = client.call
      self.response = Functions::Handler.new(self).handle if available_function?
      history.chronicle("assistant", content)
      history.messages.last.content
    end

    private

    def available_function?
      response.dig("choices", 0, "message", "function_call").present?
    end

    def content
      response.dig("choices", 0, "message", "content")
    end
  end
end
