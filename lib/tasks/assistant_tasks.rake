namespace :assistant do
  desc "Generate function files"
  task install: :environment do
    command = "rails g assistant:install setup"
    system(command)
  end
end
