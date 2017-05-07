gem_group :test do
  gem "rspec-rails"
  gem "guard-rspec"
  # my fav one <3
  gem "guard-livereload"
  gem 'faker'
end

if yes?("Would you like to install Devise?")
  gem 'Devise'
  generate "devise:install"
  model_name = ask("What would you like to name your user model? (the default is user)"
  model name = "user" if model_name.blank?
  generate "devise", model_name
end
