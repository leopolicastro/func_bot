# frozen_string_literal: true

# This is a sample function that returns a JSON string
# that will be fed into the next function in the chain.
# Please maintain the same format for your functions.

# The response from the previous function is passed in as an argument.

module FuncBot
  module Functions
    class GetCurrentWeather
      class << self
        def call(response)
          weather_info = {
            location: parsed_response(response),
            temperature: 98,
            forecast: ["sunny", "windy"]

          }

          JSON.dump(weather_info)
        end

        private

        def parsed_response(response)
          JSON.parse(response.dig("choices", 0, "message", "function_call", "arguments"))
        end
      end
    end
  end
end
