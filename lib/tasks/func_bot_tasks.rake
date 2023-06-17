namespace :func_bot do
  desc "Generate function files"
  task install: :environment do
    command = "rails g func_bot:install setup"
    system(command)
    puts "Your setup was successful!"
    puts "You can now run `rails g func_bot:function <function_name>` to generate a new function."
    puts "Please update the function list file at lib/func_bot/functions/list.yml with the functions you want to include."
  end
end
