require_relative "lib/assistant/version"

Gem::Specification.new do |spec|
  spec.name = "assistant"
  spec.version = Assistant::VERSION
  spec.authors = ["lbp"]
  spec.email = ["43428385+leopolicastro@users.noreply.github.com"]
  spec.summary = "Extensible AI Assistant with Function calls."
  spec.description = "Extensible AI Assistant with Function calls."
  spec.homepage = "https://github.com/leopolicastro/assistant"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/master/CHANGELOG.md"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.0.5"
  spec.add_dependency "ruby-openai"

  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "standard"
  spec.add_development_dependency "byebug"
end
