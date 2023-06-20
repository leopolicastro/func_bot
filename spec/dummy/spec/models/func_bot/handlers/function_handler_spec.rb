require "rails_helper"

RSpec.describe FuncBot::Functions::Handler do
  # let(:response) { double("response") }
  let(:bot) { FuncBot::Bot.new }
  let(:subject) { described_class.new(bot) }

  describe ".constantize_function" do
    it "constantizes the function name and returns the function" do
      allow(subject).to receive(:function_name)
        .and_return("WeatherFunction")

      result = subject.send :constantize_function
      expect(result).to eq("FuncBot::Functions::WeatherFunction".constantize)
    end
  end

  describe ".function_name" do
    it "returns the function name from the response" do
      response = {"choices" => [{"message" => {"function_call" => {"name" => "function_name"}}}]}
      subject.bot.response = response
      result = subject.send :function_name
      expect(result).to eq("function_name")
    end
  end

  describe ".dig_for_content" do
    it "returns the content from the response" do
      response = {"choices" => [{"message" => {"content" => "response_content"}}]}
      subject.bot.response = response
      result = subject.send :dig_for_content
      expect(result).to eq("response_content")
    end
  end
end
