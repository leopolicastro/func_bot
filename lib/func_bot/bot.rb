# frozen_string_literal: true

module FuncBot
  class Bot
    attr_accessor :role, :prompt, :history
    attr_reader :client

    def initialize
      @history = Bots::History.new
      @client = Bots::Client.new(self)
    end

    def ask(prompt)
      @prompt = prompt
      @role = "user"
      handle_response(call_openai)
    end

    private

    def call_openai
      add_prompt_to_history
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

    def add_prompt_to_history
      history.push_prompt(role, prompt)
    end
  end
end
