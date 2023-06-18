# frozen_string_literal: true

module FuncBot
  module Functions
    class List
      def self.call
        if File.exist?(Rails.root.join("lib", "func_bot", "functions", "list.yml"))
          YAML.load_file(Rails.root.join("lib", "func_bot", "functions", "list.yml"))["functions"]
        else
          raise "lib/func_bot/functions/list.yml file not found. Please create it by running rails func_bot:install."
        end
      end
    end
  end
end
