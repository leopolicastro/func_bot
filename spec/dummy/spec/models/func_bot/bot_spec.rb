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

  describe "#available_function?" do
    it "returns true if the response contains a function_call" do
      expect(subject.send(:available_function?, function_response)).to be_truthy
    end

    it "returns false if the response does not contain a function_call" do
      expect(subject.send(:available_function?, response)).to be_falsey
    end
  end
end
