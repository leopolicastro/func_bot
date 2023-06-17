module Assistant
  class InstallGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)

    def move_files_to_lib
      copy_file "openai.rb", "config/initializers/openai.rb"
      copy_file "list.yml", "lib/assistant/functions/list.yml"
      copy_file "get_current_weather.rb", "lib/assistant/functions/get_current_weather.rb"
      application do
        "config.autoload_paths << Rails.root.join('lib')"
      end
    end
  end
end
