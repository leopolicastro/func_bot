# frozen_string_literal: true

module FuncBot
  module Functions
    class Base
      class << self
        def parsed_response(response)
          JSON.parse(response.dig("choices", 0, "message", "function_call", "arguments"))
        end
      end
    end
  end
end
