RSpec.describe FuncBot::Chats::Handler do
  describe ".call" do
    let(:response) { {"choices" => [{"message" => {"content" => "Hello, world!"}}]} }
    let(:history) { [] }

    it "adds assistant's response to the history" do
      expect {
        described_class.call(response, history)
      }.to change { history.size }.by(1)
    end

    it "returns the content of the first choice message" do
      expect(described_class.call(response, history)).to eq("Hello, world!")
    end
  end
end
