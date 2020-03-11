instalar railsinstaller con todo y devtools.
instala postgres
instala node

rails new nombre --skip-git

haces el comit de git

bundle intall 

coloca postgrest en el gemfile
gem 'pg'

borra sqlite  en el gemfile

gem install bundler 

bundle install

instalar devise / (el segundo me cuadra mas)
https://github.com/heartcombo/devise 
https://guides.railsgirls.com/devise

gem install devise

bundle install

rails generate devise:install
(en este tienes que seguir las instrucciones)
/*
Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here
     is an example of default_url_options appropriate for a development environment
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root to: "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

*/

 // generas los modelos
 rails g devise user

// configura la base de datos local en este caso postgres
rails db:create

// generas 
 rails db:migrate