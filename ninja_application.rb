gem_group :test do
  gem "rspec-rails"
  gem "guard-rspec"
  # my fav one <3
  gem "guard-livereload"
  gem 'faker'
end

if yes?("Would you like to install Devise?")
  gem 'Devise'
  run "bundle install"
end
after_bundle do 
  generate "devise:install"
  model_name = ask("What would you like to name your user model? (the default is user)")
  model_name = "user" if model_name.blank?
  generate "devise", model_name
  say "We're done with dirty job, now focus on great features - Ninja girl 👩‍💻 "
end
