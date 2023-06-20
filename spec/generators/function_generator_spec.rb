require "rails_helper"

RSpec.describe FuncBot::FunctionGenerator, type: :generator do
  before do
    run_generator ["function_name"]
  end

  describe "generate_function" do
    it "creates the function file" do
      assert_file "app/lib/func_bot/functions/function_name.rb"
    end
  end

  describe "append_to_functions_list" do
    let(:yml_file_path) { Rails.root.join("app", "lib", "func_bot", "functions", "list.yml") }
    let(:yml_content) { YAML.load_file(yml_file_path) }

    it "appends the function template to the functions list in YAML file" do
      expect {
        run_generator(["func_bot:function", "function_name"])
      }.to change { YAML.load_file(yml_file_path) }.from.to(yml_content)
    end
  end
end
