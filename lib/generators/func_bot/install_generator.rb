module FuncBot
  class InstallGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)

    def move_files_to_lib
      copy_file "openai.rb", "config/initializers/openai.rb"
      copy_file "list.yml", "lib/func_bot/functions/list.yml"
      copy_file "weather_function.rb", "lib/func_bot/functions/weather_function.rb"
      application do
        "config.autoload_paths << Rails.root.join('lib')"
      end
    end
  end
end
