# frozen_string_literal: true

module FuncBot
  class Bot
    attr_accessor :role, :prompt

    delegate :history, to: :@history

    def initialize
      @history = Bots::History.new
    end

    def ask(prompt)
      @prompt = prompt
      @role = "user"
      handle_response(call_openai)
    end

    private

    def call_openai
      Bots::Client.call(chat_history)
    end

    def handle_response(response)
      if function_call?(response)
        Handlers::FunctionHandler.call(response, history)
      else
        Handlers::BotHandler.call(response, history)
      end
    end

    def function_call?(response)
      response.dig("choices", 0, "message", "function_call").present?
    end

    def chat_history
      history.push_prompt(role, prompt)
    end
  end
end
