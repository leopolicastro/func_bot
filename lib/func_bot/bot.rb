# frozen_string_literal: true

module FuncBot
  class Bot
    attr_accessor :role, :prompt

    delegate :history, to: :@history

    def initialize
      @history = Chats::History.new
    end

    def ask(prompt)
      @prompt = prompt
      @role = "user"
      handle_response(Chats::Client.call(chat_history))
    end

    private

    def handle_response(response)
      if function_call?(response)
        Functions::Handler.call(response, history)
      else
        Chats::Handler.call(response, history)
      end
    end

    def function_call?(response)
      response.dig("choices", 0, "message", "function_call").present?
    end

    def chat_history
      @history.push_prompt(role, prompt)
    end
  end
end
