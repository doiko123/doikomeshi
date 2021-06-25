source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.3.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 5.0'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

gem 'stripe', '5.30.0'

gem 'action_args', '2.5.0'

gem 'webpacker', '~> 4.x'

# Sprockets4.0だと、app/assetsディレクトリを削除するとSprockets::Railtie::ManifestNeededErrorが発生するため
gem 'sprockets', '~> 3.7.2'

gem 'slack-notifier'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # binding.pry
  gem 'pry-byebug', '3.9.0'
  gem 'pry-doc', '1.1.0'
  gem 'pry-rails', '0.3.9'

  gem 'dotenv-rails', '2.7.6'
end

group :development do
  gem 'listen', '~> 3.3'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
