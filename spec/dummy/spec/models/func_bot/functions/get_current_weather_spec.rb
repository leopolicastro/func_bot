require "rails_helper"

require "yaml"
require "json"

RSpec.describe FuncBot::Functions::WeatherFunction do
  describe ".call" do
    let(:response) do
      {
        "choices" => [
          {
            "message" => {
              "function_call" => {
                "arguments" => JSON.dump({location: "Miami, FL"})
              }
            }
          }
        ]
      }
    end

    it "returns a JSON string with weather information" do
      temp = JSON.parse(FuncBot::Functions::WeatherFunction.new(response).execute)["temperature"]
      location = JSON.parse(FuncBot::Functions::WeatherFunction.new(response).execute)["location"]
      forecast = JSON.parse(FuncBot::Functions::WeatherFunction.new(response).execute)["forecast"]
      expect(temp).to eq(98)
      expect(location).to eq("Miami, FL")
      expect(forecast).to eq(["sunny", "windy"])
    end
  end
end
