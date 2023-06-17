# frozen_string_literal: true

# This function is called when a user asks for the weather.
# It mocks a call to the weather API and returns the current weather for the requested location.

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
          JSON.parse(response.dig("choices", 0, "message", "function_call", "arguments"))["location"]
        end
      end
    end
  end
end
