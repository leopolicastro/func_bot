require "rails_helper"

RSpec.describe FuncBot::Chat, :vcr do
  let(:prompt) { "Hello, world!" }
  let(:response) { {"choices" => [{"message" => {"content" => "Response content"}}]} }
  let(:function_response) { {"choices" => [{"message" => {"function_call" => true}}]} }

  subject { described_class.new(prompt) }

  describe "#initialize" do
    it "sets the prompt" do
      expect(subject.prompt).to eq(prompt)
    end

    it "initializes history as an empty array" do
      expect(subject.history).to eq([])
    end
  end

  describe "#open" do
    before do
      allow(FuncBot::Client).to receive(:call).and_return(response)
    end

    context "when the response is not a function call" do
      it "calls handle_chat_response with the response" do
        expect(subject).to receive(:handle_chat_response).with(response)
        subject.open
      end

      it "adds the chat response to the history" do
        expect { subject.open }.to change { subject.history.length }.by(2)
      end
    end

    context "when the response is a function call" do
      before do
        allow(FuncBot::Client).to receive(:call).and_return(function_response)
      end

      it "calls Functions::Handler.call with the response and history" do
        expect(FuncBot::Functions::Handler).to receive(:call).with(function_response, subject.history)
        subject.open
      end
    end
  end

  describe "#handle_response" do
    context "when the response is a function call" do
      it "calls Functions::Handler.call with the response and history" do
        VCR.use_cassette("func_bot/chat/handle_response") do
          expect(FuncBot::Functions::Handler).to receive(:call)
          subject.send(:handle_response,
            FuncBot::Client.call(
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
      it "calls handle_chat_response with the response" do
        expect(subject).to receive(:handle_chat_response).with(response)
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

  describe "#handle_chat_response" do
    it "adds the chat response to the history" do
      expect { subject.send(:handle_chat_response, response) }.to change { subject.history.length }.by(1)
    end

    it "returns the content of the chat response" do
      expect(subject.send(:handle_chat_response, response)).to eq("Response content")
    end
  end

  describe "#dig_for_content" do
    it "returns the content from the response" do
      expect(subject.send(:dig_for_content, response)).to eq("Response content")
    end
  end

  describe "#messages" do
    it "adds a new message to the history with the user role and prompt content" do
      expect { subject.send(:messages) }.to change { subject.history.length }.by(1)
      expect(subject.history.last).to eq({role: "user", content: prompt})
    end
  end
end
