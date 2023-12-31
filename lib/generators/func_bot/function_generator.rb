module FuncBot
  class FunctionGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)

    def generate_function
      template "function.rb", "app/lib/func_bot/functions/#{file_name}_function.rb"
      template "function_spec.rb", "spec/models/func_bot/functions/#{file_name}_function_spec.rb" if defined?(RSpec)
      puts "Update the function list file at lib/func_bot/functions/list.yml with the details of your new function."
    end

    def append_to_functions_list
      yml = YAML.load_file(yml_file)
      yml["functions"] << function_template
      File.write(yml_file, yml.to_yaml.gsub("---\n", ""))
    end

    private

    def yml_file
      Rails.root.join("app", "lib", "func_bot", "functions", "list.yml")
    end

    def function_template
      {
        name: "#{class_name}Function",
        description: "TODO: Write a description for this function.",
        parameters: {
          type: "TODO: choose from string, integer, boolean, object, etc.",
          properties: {
            location: {
              type: "TODO: Write a type for this parameter. e.g. string, integer, etc.",
              description: "TODO: Write a description for this parameter."
            }
          },
          required: ["TODO: list the required parameters here"]
        }
      }
    end
  end
end
