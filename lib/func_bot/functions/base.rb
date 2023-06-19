# frozen_string_literal: true

module FuncBot
  module Functions
    class Base
      attr_reader :response

      def initialize(response)
        @response = response
      end

      def parsed_response
        JSON.parse(response.dig("choices", 0, "message", "function_call", "arguments"))
      end
    end
  end
end
