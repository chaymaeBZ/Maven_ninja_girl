require_relative 'custom_behaviour'



# init git and save a before state 

git :init 
git add: "."
git commit: "-m init"

gem_group :test do
  gem "rspec-rails"
  gem "guard-rspec"
  # my fav one <3
  gem 'faker'
end

gem_group :development do
  gem "guard-livereload"
end

if yes?("Is it an API ?")
  if yes?("| -- Do you want to use GraphQL ?")
    gem "graphql"
    @using_graphql = true
  end
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
    run 'mv application.css application.css.scss'
    inject_into_file 'application.css.scss', after: "*/\n" do
      "@import 'bootstrap-sprockets' \n@import 'bootstrap' \n"
    end
  end
elsif yes?("then maybe you want to use semantic ui?")
  gem 'semantic-ui-sass', git: 'https://github.com/doabit/semantic-ui-sass.git'
    
  inside ('app/assets/stylesheets') do
    run 'mv application.css application.css.scss'
    inject_into_file 'application.css.scss', after: "*/\n" do
      "@import 'semantic-ui'"
    end
  end
elsif yes?("Or Materialize ?? 👀 ") 
  gem 'materialize-sass'
  
  # materialize extra configs  
  inside ('app/assets/stylesheets') do
    run 'mv application.css application.css.scss'
    inject_into_file 'application.css.scss', after: "*/\n" do
      "@import 'materialize'"
    end
  end
  # TODO : Figure out what version of turbolinks that is used ... Hmmm 
  inject_into_file 'app/assets/javascripts/application.js', after: "//= require jquery\n" do
    "//= require materialize-sprockets\n"
  end 
end

if yes?("do u want to bundle now")  
  git add: "."
  git commit: "-m 'added necessary gems'"
  run "bundle install"
end
after_bundle do
  if !!@using_devise
    run "spring stop"
    generate "devise:install"
    model_name = ask("What would you like to name your user model? (the default is user)")
    model_name = "user" if model_name.blank?
    generate "devise", model_name
    git add: "."
    git commit: "-m 'setup devise basics done'"
  end

  if @using_graphql
    dir_architecture = { app: { types: "query_type.rb" } }
    generate "graphql:install"
    puts "Generating schema files for graphql ..."
    inside('app/types') do 
      # Generate content for query root
    end
    # Join the new tree to Load path
  end

  rake "db:migrate"  
  say "We're done with dirty job, now focus on great features - Ninja girl  👩‍💻 ", :bold
  say " \033[1;35mbyebye :)\033[0m\n "

end
