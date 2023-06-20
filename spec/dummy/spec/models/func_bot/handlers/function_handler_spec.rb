require "rails_helper"

RSpec.describe FuncBot::Handlers::FunctionHandler do
  let(:response) { double("response") }
  let(:bot) { FuncBot::Bot.new }
  let(:subject) { described_class.new(response, bot) }

  describe ".constantize_function" do
    it "constantizes the function name and returns the function" do
      allow(subject).to receive(:function_name)
        .and_return("WeatherFunction")

      result = subject.constantize_function
      expect(result).to eq("FuncBot::Functions::WeatherFunction".constantize)
    end
  end

  describe ".function_name" do
    it "returns the function name from the response" do
      response = {"choices" => [{"message" => {"function_call" => {"name" => "function_name"}}}]}
      subject.response = response
      result = subject.function_name
      expect(result).to eq("function_name")
    end
  end

  describe ".dig_for_content" do
    it "returns the content from the response" do
      response = {"choices" => [{"message" => {"content" => "response_content"}}]}
      subject.response = response
      result = subject.dig_for_content
      expect(result).to eq("response_content")
    end
  end

  describe ".respond_to" do
    let(:prompt) { "prompt_message" }

    it "calls Client.call with the messages" do
      allow(subject).to receive(:messages)
        .and_return([{role: "function", content: prompt, name: nil}])

      expect(subject.bot.client).to receive(:call)

      subject.respond_to(prompt)
    end
  end
end
