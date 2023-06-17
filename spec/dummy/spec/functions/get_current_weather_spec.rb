require "rails_helper"

require "yaml"
require "json"

RSpec.describe FuncBot::Functions::GetCurrentWeather do
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
      temp = JSON.parse(FuncBot::Functions::GetCurrentWeather.call(response))["temperature"]
      location = JSON.parse(FuncBot::Functions::GetCurrentWeather.call(response))["location"]
      forecast = JSON.parse(FuncBot::Functions::GetCurrentWeather.call(response))["forecast"]
      expect(temp).to eq(98)
      expect(location).to eq({"location" => "Miami, FL"})
      expect(forecast).to eq(["sunny", "windy"])
    end
  end
end
