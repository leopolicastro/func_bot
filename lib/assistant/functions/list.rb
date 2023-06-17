module Assistant
  module Functions
    class List
      def self.call
        [
          {
            name: "GetCurrentWeather",
            description: "Get the current weather forecast for a given location.",
            parameters: {
              type: "object",
              properties: {
                location: {
                  type: "string",
                  description: "The city and state eg. 'Miami, FL'"
                }
              },
              required: ["location"]
            }
          }
        ]
      end
    end
  end
end
