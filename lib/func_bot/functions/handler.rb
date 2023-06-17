require_relative "../client"

module FuncBot
  module Functions
    class Handler
      attr_reader :prompt, :history

      class << self
        def call(response, history)
          @function_name = nil
          @history = history
          function_return = constantize_function(response).call(response)
          response = respond_to(function_return)
          history << {role: "func_bot", content: dig_for_content(response)}
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
          Client.call(messages)
        end

        def messages
          @history << {role: "function", content: @prompt, name: function_name}
        end
      end
    end
  end
end
