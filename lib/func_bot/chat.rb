require_relative "functions/handler"
require_relative "chats/handler"

module FuncBot
  class Chat
    attr_accessor :history, :role, :prompt

    def initialize
      @history = []
    end

    def ask(prompt)
      @prompt = prompt
      @role = "user"
      handle_response(Client.call(messages))
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

    def messages
      @history << {role: @role, content: prompt}
    end
  end
end
