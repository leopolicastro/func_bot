require "rails_helper"

RSpec.describe FuncBot::Handlers::FunctionHandler do
  let(:response) { double("response") }
  let(:history) { [] }

  describe ".call" do
    let(:function_return) { double("function_return") }
    let(:response_data) do
      {
        "choices" => [
          {
            "message" => {
              "function_call" => {
                "name" => "function_name"
              },
              "content" => "response_content"
            }
          }
        ]
      }
    end

    before do
      allow(FuncBot::Handlers::FunctionHandler).to receive(:constantize_function)
        .with(response)
        .and_return(double(:execute))

      allow(FuncBot::Handlers::FunctionHandler).to receive(:respond_to)
        .with(function_return)
        .and_return(response_data)

      allow(FuncBot::Handlers::FunctionHandler).to receive(:dig_for_content)
        .with(response_data)
        .and_return("content_value")
    end
  end

  describe ".constantize_function" do
    it "constantizes the function name and returns the function" do
      response = double("response")
      allow(FuncBot::Handlers::FunctionHandler).to receive(:function_name)
        .with(response)
        .and_return("GetCurrentWeather")

      result = FuncBot::Handlers::FunctionHandler.constantize_function(response)
      expect(result).to eq("FuncBot::Functions::GetCurrentWeather".constantize)
    end
  end

  describe ".function_name" do
    it "returns the function name from the response" do
      response = {"choices" => [{"message" => {"function_call" => {"name" => "function_name"}}}]}
      result = FuncBot::Handlers::FunctionHandler.function_name(response)
      expect(result).to eq("function_name")
    end
  end

  describe ".dig_for_content" do
    it "returns the content from the response" do
      response = {"choices" => [{"message" => {"content" => "response_content"}}]}
      result = FuncBot::Handlers::FunctionHandler.dig_for_content(response)
      expect(result).to eq("response_content")
    end
  end

  describe ".respond_to" do
    let(:prompt) { "prompt_message" }

    it "calls Client.call with the messages" do
      allow(FuncBot::Handlers::FunctionHandler).to receive(:messages)
        .and_return([{role: "function", content: prompt, name: nil}])

      expect(FuncBot::Bots::Client).to receive(:call)
        .with([{role: "function", content: prompt, name: nil}])

      FuncBot::Handlers::FunctionHandler.respond_to(prompt)
    end
  end
end
