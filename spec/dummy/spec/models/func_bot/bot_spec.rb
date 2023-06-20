require "rails_helper"

RSpec.describe FuncBot::Bot, :vcr do
  let(:prompt) { "Hello, world!" }
  let(:response) { {"choices" => [{"message" => {"content" => "Response content"}}]} }
  let(:function_response) { {"choices" => [{"message" => {"function_call" => true}}]} }
  subject { described_class.new }
  let(:bot_handler) { FuncBot::Handlers::BotHandler.new(response, subject) }

  describe "#initialize" do
    it "initializes history as an empty array" do
      # expect it to be an instance of Bots::History
      expect(subject.history).to be_an_instance_of(FuncBot::Bots::History)
    end
  end

  describe "#ask(prompt)" do
    before do
      allow(subject.client).to receive(:call).and_return(response)
    end

    context "when the response is a function call" do
      before do
        allow(subject.client).to receive(:call).and_return(function_response)
      end

      it "calls Handlers::FunctionHandler.call with the response and history" do
        expect_any_instance_of(FuncBot::Functions::Handler).to receive(:handle).and_return(response)
        subject.ask(prompt)
      end
    end
  end

  describe "#handle_response" do
    context "when the response is a function call" do
      it "calls Handlers::FunctionHandler.call with the response and history" do
        VCR.use_cassette("func_bot/chat/handle_response") do
          expect_any_instance_of(FuncBot::Functions::Handler).to receive(:handle).and_return(response)

          subject.send(:handle_response,
            subject.client.call)
        end
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
end
