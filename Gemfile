# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gemspec

group :test do
  # if ENV['USE_PRY']
    gem 'pry'
    gem 'pry-byebug'
  # end

  gem 'rspec'
  gem 'timecop'
  gem 'simplecov'
  # gem 'fugit'
  # gem 'rake'
end
