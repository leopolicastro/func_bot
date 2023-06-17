require "rails_helper"
require "generator_spec"

require_relative "../../lib/generators/func_bot/function_generator"

RSpec.describe FuncBot::FunctionGenerator, type: :generator do
  # destination File.expand_path("../../tmp", __FILE__)

  before do
    # prepare_destination
    run_generator ["function_name"]
  end

  describe "generate_function" do
    it "creates the function file" do
      assert_file "lib/func_bot/functions/function_name.rb"
    end
  end

  describe "append_to_functions_list" do
    let(:yml_file_path) { Rails.root.join("lib", "func_bot", "functions", "list.yml") }
    let(:yml_content) { YAML.load_file(yml_file_path) }

    it "appends the function template to the functions list in YAML file" do
      expect {
        run_generator(["func_bot:function", "function_name"])
      }.to change { YAML.load_file(yml_file_path) }.from.to(yml_content)
    end
  end
end
