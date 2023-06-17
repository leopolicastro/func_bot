module FuncBot
  module Functions
    class GetCurrentWeather
      def self.call(response)
        weather_info = {
          location: parsed_response(response),
          temperature: 72,
          forecast: ["sunny", "windy"]

        }

        JSON.dump(weather_info)
      end

      def self.parsed_response(response)
        JSON.parse(response.dig("choices", 0, "message", "function_call", "arguments"))
      end
    end
  end
end
