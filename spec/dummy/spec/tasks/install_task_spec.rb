# spec/tasks/func_bot_spec.rb

require "rails_helper"
require "rake"

RSpec.describe "func_bot:install" do
  describe "install" do
    before(:all) do
      Rake.application.rake_require("tasks/func_bot_tasks")
      Rake::Task.define_task(:environment)
    end

    it "generates function files" do
      expect { Rake::Task["func_bot:install"].invoke }.to output(/Your setup was successful!/).to_stdout
    end
  end
end
