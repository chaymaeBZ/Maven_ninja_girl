gem_group :test do
  gem "rspec-rails"
  gem "guard-rspec"
  # my fav one <3
  gem "guard-livereload"
  gem 'faker'
end

if yes?("Would you like to install Devise?")
  gem "devise"

end

if yes?("do u want to bundle now")  
  run "bundle install"
end
after_bundle do
  run "spring stop"
  generate "devise:install"
  model_name = ask("What would you like to name your user model? (the default is user)")
  model_name = "user" if model_name.blank?
  generate "devise", model_name
  say "\033[1mWe're done with dirty job, now focus on great features - Ninja girl\033[0m  👩‍💻 "
  say " \033[1;35mbyebye :)\033[0m "

end
