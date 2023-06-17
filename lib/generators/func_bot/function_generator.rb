module FuncBot
  class FunctionGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)

    def generate_function
      template "function.rb", "lib/func_bot/functions/#{file_name}.rb"
    end

    def append_to_functions_list
      yml = YAML.load_file(yml_file)
      yml["functions"] << function_template
      File.write(yml_file, yml.to_yaml.gsub("---\n", ""))
    end

    private

    def yml_file
      Rails.root.join("lib", "func_bot", "functions", "list.yml")
    end

    def function_template
      {name: class_name.to_s,
       description: "TODO: Write a description for this function.",
       parameters: {
         type: "TODO: choose from string, integer, boolean, object, etc.",
         properties: {
           location: {
             type: "TODO: Write a type for this parameter. e.g. string, integer, etc.",
             description: "TODO: Write a description for this parameter."
           }
         },
         required: ["TODO: list the reuiqred parameters here"]
       }}
    end
  end
end
