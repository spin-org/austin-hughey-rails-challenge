source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

gem 'rails', '~> 5.2.3'
gem 'pg', '~> 1.1.4'
gem 'puma', '~> 3.11'
gem 'activerecord-postgis-adapter'

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 3.8.2'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'simplecov', require: false, group: :test
end
