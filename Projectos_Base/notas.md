instalar railsinstaller con todo y devtools.
quizas toca instalar tambien rubyinstaller....
usar la consola de ruby de railsintaller para evitar problemas (!!!!)

instala postgres
instala node

rails new nombre --skip-git

haces el comit de git

gem install bundler 
bundle intall 

borra sqlite  en el gemfile
coloca postgrest en el gemfile
gem install pg


bundle install

instalar devise / (el segundo me cuadra mas)
https://github.com/heartcombo/devise 
https://guides.railsgirls.com/devise

gem install devise

bundle install
(si te sale algo gem update --system)
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

 // webpacker... no estaba automatico instalado
 rails webpacker:install

// agrega node_modules al git ignore....

// forgot that
gem install bundler
bundle update
bundle install

rails g scaffold profile cedula:integer name:string Users:references

rails g scaffold transaction amount:float phone:string sender_id:user_id:references receiver_id:user_id:references bank:string timestamps 