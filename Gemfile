source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'devise'
gem 'simple_form'
gem 'inline_svg'
gem 'kaminari', github: "amatsuda/kaminari"
gem 'chartkick'
gem 'groupdate'
gem 'gemoji'
gem 'active_link_to', github: "pradyumna2905/active_link_to",
  branch: "regex-enhanced"
gem 'font-awesome-rails'

# HAML
gem 'hamlit'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'faker', github: 'stympy/faker'
  gem 'simplecov', require: false
  gem 'pry'
  gem 'pry-nav'
  gem 'rails-controller-testing'
  gem 'capybara'
  gem 'capybara-webkit'
end

group :test do
  gem 'database_cleaner'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'bullet'
  gem 'better_errors'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
