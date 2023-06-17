module FuncBot
  module Functions
    class FuncBot:function
      def self.call(response)

      end

      def self.parsed_response(response)
        JSON.parse(response.dig("choices", 0, "message", "function_call", "arguments"))
      end
    end
  end
end
