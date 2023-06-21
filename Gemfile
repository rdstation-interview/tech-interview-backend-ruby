source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.4"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.5"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem "rack-cors"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end


group :development, :test do
  gem "rspec-rails", require: false
  gem "rexml", "~> 3.2", ">= 3.2.4"
  gem "simplecov", "0.17.1"
end
gem "ddtrace", require: "ddtrace/auto_instrument"

source "https://resultadosdigitais.jfrog.io/resultadosdigitais/api/gems/gems" do
  gem "microservice-toolkit"
end

Dir.glob("components/**/*.gemspec") do |gemspec|
  path      = File.dirname(gemspec)
  component = File.basename(path)

  gem component, path: path
end

gem 'rollbar'


# Optional gems

# Feature Flagger (https://github.com/ResultadosDigitais/feature_flagger)
# In order to enable Feature Flagger in your application, you must:
# - Uncomment the gem below
# - Uncomment the lines on config/initializers/feature_flagger.rb
# - Uncomment the redis service on docker-compose.yml

# gem 'feature_flagger'
