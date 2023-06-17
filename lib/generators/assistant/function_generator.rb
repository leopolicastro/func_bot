module Assistant
  class FunctionGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)

    def generate_function
      template "function.rb", "lib/assistant/functions/#{file_name}.rb"
      # copy_file "../../assistant/functions/list.rb", "lib/assistant/functions/list.rb"
    end

    def append_to_functions_list
      current_yml = YAML.load_file(yml_file)
      current_yml["functions"] << function_template
      File.write(yml_file, current_yml.to_yaml.gsub("---\n", ""))
    end

    private

    def yml_file
      Rails.root.join("lib", "assistant", "functions", "list.yml")
    end

    def function_template
      {name: "#{class_name}",
       description: "TODO: Write a description for this function.",
       parameters: {
         type: "object",
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
