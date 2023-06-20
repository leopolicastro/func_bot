require "rails_helper"

require "json"

RSpec.describe FuncBot::Functions::BaseFunction do
  let(:bot) { FuncBot::Bot.new }
  let(:response) do
    {
      "choices" => [
        {
          "message" => {
            "function_call" => {
              "arguments" => '{"arg1": "value1", "arg2": "value2"}'
            }
          }
        }
      ]
    }
  end

  before do
    bot.response = response
  end

  subject { described_class.new(bot) }

  describe "#initialize" do
    it "assigns the response" do
      expect(subject.bot.response).to eq(response)
    end
  end

  describe "#parsed_response" do
    it "returns the parsed JSON arguments" do
      expected_result = {"arg1" => "value1", "arg2" => "value2"}
      expect(subject.parsed_response).to eq(expected_result)
    end
  end
end
