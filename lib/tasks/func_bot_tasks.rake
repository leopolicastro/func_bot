namespace :func_bot do
  desc "Generate function files"
  task install: :environment do
    command = "rails g func_bot:install setup"
    system(command)
  end
end
