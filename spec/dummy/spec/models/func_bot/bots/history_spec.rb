require "rails_helper"

module FuncBot
  module Bots
    describe History do
      let(:history) { History.new }

      describe "#initialize" do
        it "initializes messages as an empty array" do
          expect(history.chronicles).to be_an(Array)
          expect(history.chronicles).to be_empty
        end
      end

      describe "#chronicle" do
        it "adds a new message to the messages array" do
          expect {
            history.chronicle("user", "Hello")
          }.to change(history.chronicles, :size).by(1)

          expect(history.chronicles.last).to be_a(FuncBot::Bots::Message)
          expect(history.chronicles.last.data[:role]).to eq("user")
          expect(history.chronicles.last.data[:content]).to eq("Hello")
        end
      end
    end
  end
end
