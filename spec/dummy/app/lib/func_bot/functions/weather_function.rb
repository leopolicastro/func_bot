# frozen_string_literal: true

# This function is called when a user asks for the weather.
# It mocks a call to the weather API and returns the current weather for the requested location.

module FuncBot
  module Functions
    class WeatherFunction < BaseFunction
      def execute
        weather_info = {
          location: parsed_response["location"],
          temperature: 98,
          forecast: ["sunny", "windy"]
        }

        JSON.dump(weather_info)
      end
    end
  end
end
