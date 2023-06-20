require "rails_helper"

RSpec.describe FuncBot::Functions::List do
  let(:bot) { FuncBot::Bot.new }
  describe ".call" do
    context "when list.yml file exists" do
      let(:functions) {
        {"functions" => ["function1", "function2"]}
      }

      before do
        allow(File).to receive(:exist?).and_return(true)
        allow(YAML).to receive(:load_file).and_return(functions)
      end

      it "returns the functions from list.yml" do
        expect(described_class.call(bot)).to eq(functions["functions"])
      end
    end

    context "when list.yml file does not exist" do
      before do
        allow(File).to receive(:exist?).and_return(false)
      end

      it "raises an error" do
        expect { described_class.call(bot) }.to raise_error("app/lib/func_bot/functions/list.yml file not found. Please create it by running rails func_bot:install.")
      end
    end
  end
end
