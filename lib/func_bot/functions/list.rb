# frozen_string_literal: true

module FuncBot
  module Functions
    class List
      def self.call(bot)
        if bot.include_functions
          if File.exist?(Rails.root.join("app", "lib", "func_bot", "functions", "list.yml"))
            YAML.load_file(Rails.root.join("app", "lib", "func_bot", "functions", "list.yml"))["functions"]
          else
            raise "app/lib/func_bot/functions/list.yml file not found. Please create it by running rails func_bot:install."
          end
        else
          []
        end
      end
    end
  end
end
