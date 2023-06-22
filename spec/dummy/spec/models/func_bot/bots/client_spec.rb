require "rails_helper"

RSpec.describe FuncBot::Bots::Client do
  describe ".call" do
    let(:bot) { FuncBot::Bot.new }
    let(:subject) {
      described_class.new(bot)
    }

    it "calls the OpenAI client with the correct parameters" do
      expect(subject.send(:open_ai)).to receive(:chat).with(
        parameters: {
          model: "gpt-3.5-turbo-0613",
          messages: subject.bot.history.payload,
          temperature: 0.7,
          functions: FuncBot::Functions::List.call
        }
      )
      subject.call
    end

    it "returns the result from the OpenAI client" do
      result = {"response" => "This is the response"}
      allow(subject.send(:open_ai)).to receive(:chat).and_return(result)

      expect(subject.call).to eq(result)
    end

    describe ".open_ai" do
      it "returns an instance of OpenAI::Client" do
        expect(subject.send(:open_ai)).to be_an_instance_of(OpenAI::Client)
      end

      it "returns the same instance on subsequent calls" do
        first_call = subject.send :open_ai
        second_call = subject.send :open_ai
        expect(first_call).to eq(second_call)
      end
    end
  end
end
