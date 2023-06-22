namespace :func_bot do
  desc "Generate function files"
  task install: :environment do
    command = "rails g func_bot:install setup"
    system(command)
    puts "FuncBot successfully installed."
    puts "♪┏(°.°)┛┗(°.°)┓┗(°.°)┛┏(°.°)┓ ♪"
    puts "Run `rails g func_bot:function <function_name>` to generate a new function."
  end
end
