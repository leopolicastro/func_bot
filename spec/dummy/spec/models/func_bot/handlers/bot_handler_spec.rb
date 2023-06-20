require "rails_helper"

RSpec.describe FuncBot::Handlers::BotHandler do
  describe ".call" do
    let(:response) { {"choices" => [{"message" => {"content" => "Hello, world!"}}]} }
    let(:bot) { FuncBot::Bot.new }
    subject { described_class.new(response, bot) }

    it "adds assistant's response to the history" do
      expect {
        subject.handle
      }.to change { bot.history.messages.size }.by(1)
    end

    it "returns the right content" do
      expect(subject.handle).to eq("Hello, world!")
    end
  end
end
