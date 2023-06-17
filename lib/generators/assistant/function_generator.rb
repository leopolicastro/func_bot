module Assistant
  class FunctionGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)

    def generate_function
      template "function.rb", "lib/assistant/functions/#{file_name}.rb"
      copy_file "../../assistant/functions/list.rb", "lib/assistant/functions/list.rb"
    end

    def append_to_functions_list
      inject_into_file "lib/assistant/functions/list.rb", before: before_inject do
        object_template
      end
    end

    private

    def before_inject
      <<~TEXT
              ]
              end
            end
          end
        end
      TEXT
    end

    def object_template
      <<~TEXT
        {
          name: "#{class_name}",
          description: "TODO: Add description.",
          parameters: {
            type: "object",
            properties: {
              # TODO: Add property.
            },
            required: []
          }
        },
      TEXT
    end
  end
end
