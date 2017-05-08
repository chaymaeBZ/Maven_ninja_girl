require_relative 'custom_behaviour'

gem_group :test do
  gem "rspec-rails"
  gem "guard-rspec"
  # my fav one <3
  gem "guard-livereload"
  gem 'faker'
end

if yes?("Would you like to install Devise?")
  gem "devise"
  @using_devise = true
end

if yes?("do you want to use Bootstrap for your frontend ?")

  gem 'bootstrap-sass'
  gem 'autoprefixer-rails'

  # bootstrap extra configurations
  inject_into_file 'app/assets/javascripts/application.js', after: "//= require jquery\n" do
    "//= require bootstrap-sprockets\n"
  end 

  inside ('app/assets/stylesheets') do
    run 'mv application.css application.css.sass'
    inject_into_file 'application.css.sass', after: "*/\n" do
      "@import 'bootstrap-sprockets' \n@import 'bootstrap' \n"
    end
  end

end

if yes?("do u want to bundle now")  
  run "bundle install"
end
after_bundle do
  if @using_devise
    run "spring stop"
    generate "devise:install"
    model_name = ask("What would you like to name your user model? (the default is user)")
    model_name = "user" if model_name.blank?
    generate "devise", model_name
  end
  rake "db:migrate"  
  say "We're done with dirty job, now focus on great features - Ninja girl  👩‍💻 ", :bold
  say " \033[1;35mbyebye :)\033[0m\n "

end
