source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Specify your gem's dependencies in func_bot.gemspec.
gemspec

gem "puma"

gem "pg"

gem "sprockets-rails"

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"
group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
  gem "shoulda-matchers", "~> 5.0"
  gem "vcr"
  gem "coderay"
end
gem "simplecov", require: false, group: :test
gem "generator_spec", group: :test
