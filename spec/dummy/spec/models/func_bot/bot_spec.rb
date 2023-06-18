require "rails_helper"

RSpec.describe FuncBot::Bot, :vcr do
  let(:prompt) { "Hello, world!" }
  let(:response) { {"choices" => [{"message" => {"content" => "Response content"}}]} }
  let(:function_response) { {"choices" => [{"message" => {"function_call" => true}}]} }

  subject { described_class.new }

  describe "#initialize" do
    it "initializes history as an empty array" do
      expect(subject.history).to eq([])
    end
  end

  describe "#ask(prompt)" do
    before do
      allow(FuncBot::Bots::Client).to receive(:call).and_return(response)
    end

    context "when the response is a function call" do
      before do
        allow(FuncBot::Bots::Client).to receive(:call).and_return(function_response)
      end

      it "calls Handlers::FunctionHandler.call with the response and history" do
        expect(FuncBot::Handlers::FunctionHandler).to receive(:call).with(function_response, subject.history)
        subject.ask(prompt)
      end
    end
  end

  describe "#handle_response" do
    context "when the response is a function call" do
      it "calls Handlers::FunctionHandler.call with the response and history" do
        VCR.use_cassette("func_bot/chat/handle_response") do
          expect(FuncBot::Handlers::FunctionHandler).to receive(:call)

          subject.send(:handle_response,
            FuncBot::Bots::Client.call(
              [
                {
                  "role" => "user",
                  "content" => "What is the weather like today in Miami, FL?"
                }
              ]
            ))
        end
      end
    end

    context "when the response is not a function call" do
      it "calls the Handlers::BotHandler.call method" do
        expect(FuncBot::Handlers::BotHandler).to receive(:call)
        subject.send(:handle_response, response)
      end
    end
  end

  describe "#function_call?" do
    it "returns true if the response contains a function_call" do
      expect(subject.send(:function_call?, function_response)).to be_truthy
    end

    it "returns false if the response does not contain a function_call" do
      expect(subject.send(:function_call?, response)).to be_falsey
    end
  end

  describe "#chat_history" do
    before do
      subject.role = "user"
      subject.prompt = prompt
    end
    it "adds a new message to the history with the user role and prompt content" do
      expect { subject.send(:chat_history) }.to change { subject.history.length }.by(1)
      expect(subject.history.last).to eq({role: "user", content: prompt})
    end
  end
end
