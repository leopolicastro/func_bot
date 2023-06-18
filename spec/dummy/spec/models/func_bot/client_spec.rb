require "rails_helper"

RSpec.describe FuncBot::Bots::Client do
  describe ".call" do
    let(:messages) { [] << {role: "user", content: "Hello, How are you?"} }

    it "calls the OpenAI client with the correct parameters" do
      expect(FuncBot::Bots::Client.client).to receive(:chat).with(
        parameters: {
          model: "gpt-3.5-turbo-0613",
          messages: messages,
          temperature: 0.7,
          functions: FuncBot::Functions::List.call
        }
      )
      FuncBot::Bots::Client.call(messages)
    end

    it "returns the result from the OpenAI client" do
      result = {"response" => "This is the response"}
      allow(FuncBot::Bots::Client.client).to receive(:chat).and_return(result)

      expect(FuncBot::Bots::Client.call(messages)).to eq(result)
    end
  end

  describe ".client" do
    it "returns an instance of OpenAI::Client" do
      expect(FuncBot::Bots::Client.client).to be_an_instance_of(OpenAI::Client)
    end

    it "returns the same instance on subsequent calls" do
      first_call = FuncBot::Bots::Client.client
      second_call = FuncBot::Bots::Client.client
      expect(first_call).to eq(second_call)
    end
  end
end
