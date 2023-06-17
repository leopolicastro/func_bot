module Assistant
  module Functions
    class List
      def self.call
        # if the Rails.root.join("lib", "assistant", "functions", "list.json") file exists, use it
        # otherwise, use the default list
        if File.exist?(Rails.root.join("lib", "assistant", "functions", "list.yml"))
          YAML.load_file(Rails.root.join("lib", "assistant", "functions", "list.yml"))["functions"]
        else
          raise "lib/assistant/functions/list.yml file not found. Please create it by running rails assistant:install."
        end
      end
    end
  end
end
