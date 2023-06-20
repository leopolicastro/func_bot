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
    attr_reader :client, :history
    # attr_accessor :response
    def initialize
      @history = Bots::History.new
      @client = Bots::Client.new(self)
    end

    def ask(prompt)
      history.chronicle("user", prompt)
      response = client.call
      response = Functions::Handler.new(response, self).handle if available_function?(response)
      history.chronicle("assistant", content(response))
      history.chronicles.last.content
    end

    private

    def available_function?(response)
      response.dig("choices", 0, "message", "function_call").present?
    end

    def content(response)
      response.dig("choices", 0, "message", "content")
    end
  end
end
