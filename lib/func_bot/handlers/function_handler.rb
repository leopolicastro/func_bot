# frozen_string_literal: true

module FuncBot
  module Handlers
    class FunctionHandler
      attr_accessor :prompt, :history

      class << self
        def call(response, history)
          @function_name = nil
          @history = history
          function_return = constantize_function(response).new(response).execute
          response = respond_to(function_return)
          history << Bots::Message.new("assistant", dig_for_content(response)).data
          dig_for_content(response)
        end

        def constantize_function(response)
          "FuncBot::Functions::#{function_name(response)}".constantize
        end

        def function_name(response = {})
          @function_name ||= response.dig("choices", 0, "message", "function_call", "name")
        end

        def dig_for_content(response)
          response.dig("choices", 0, "message", "content")
        end

        def respond_to(prompt)
          @prompt = prompt
          Bots::Client.call(messages)
        end

        def messages
          @history << Bots::Message.new("function", @prompt, function_name).data
        end
      end
    end
  end
end
