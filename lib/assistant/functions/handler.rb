require_relative "../client"

module Assistant
  module Functions
    class Handler
      attr_reader :prompt, :history

      def self.call(response, history)
        @function_name = nil
        @history = history
        function_return = constantize_function(response).call(response)
        response = respond_to(function_return)
        history << {role: "assistant", content: dig_for_content(response)}
        dig_for_content(response)
      end

      def self.constantize_function(response)
        "Assistant::Functions::#{function_name(response)}".constantize
      end

      def self.function_name(response = {})
        @function_name ||= response.dig("choices", 0, "message", "function_call", "name")
      end

      def self.dig_for_content(response)
        response.dig("choices", 0, "message", "content")
      end

      def self.respond_to(prompt)
        @prompt = prompt
        Client.call(messages)
      end

      def self.messages
        @history << {role: "function", content: @prompt, name: function_name}
      end
    end
  end
end
