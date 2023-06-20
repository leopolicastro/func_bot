require "rails_helper"

module FuncBot
  module Bots
    describe History do
      let(:history) { History.new }

      describe "#initialize" do
        it "initializes messages as an empty array" do
          expect(history.messages).to be_an(Array)
          expect(history.messages).to be_empty
        end
      end

      describe "#chronicle" do
        it "adds a new message to the messages array" do
          expect {
            history.chronicle("user", "Hello")
          }.to change(history.messages, :size).by(1)

          expect(history.messages.last).to be_a(Hash)
          expect(history.messages.last[:role]).to eq("user")
          expect(history.messages.last[:content]).to eq("Hello")
        end
      end
    end
  end
end
