require "rails_helper"

RSpec.describe FuncBot::Functions::WeatherFunction, :vcr do
  describe "#execute" do
    let(:bot) { FuncBot::Bot.new }
    let(:function_response) { described_class.new(bot).execute }
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

    before do
      bot.response = response
    end

    it "returns a JSON string with weather information" do
      temp = JSON.parse(function_response)["temperature"]
      location = JSON.parse(function_response)["location"]
      forecast = JSON.parse(function_response)["forecast"]
      expect(temp).to eq(98)
      expect(location).to eq("Miami, FL")
      expect(forecast).to eq(["sunny", "windy"])
    end
  end
end
