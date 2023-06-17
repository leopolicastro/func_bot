module Assistant
  class InstallGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)

    def move_files_to_lib
      copy_file "list.rb", "lib/assistant/functions/list.rb"
      copy_file "get_current_weather.rb", "lib/assistant/functions/get_current_weather.rb"
    end
  end
end
