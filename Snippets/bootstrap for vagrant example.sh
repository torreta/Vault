# The output of all these installation steps is noisy. With this utility
# the progress report is nice and concise.
function install {
    echo installing $1
    shift
    apt-get -y install "$@" >/dev/null 2>&1
}

echo adding swap file
fallocate -l 1G /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
echo '/swapfile none swap defaults 0 0' >> /etc/fstab

echo updating package information
apt-add-repository -y ppa:brightbox/ruby-ng >/dev/null 2>&1
apt-get -y update >/dev/null 2>&1

install 'development tools' build-essential git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev python-software-properties libffi-dev

install Ruby ruby2.3 ruby2.3-dev
update-alternatives --set ruby /usr/bin/ruby2.3 >/dev/null 2>&1
update-alternatives --set gem /usr/bin/gem2.3 >/dev/null 2>&1

echo installing Bundler
gem install bundler
#-N >/dev/null 2>&1

install Git git
install SQLite sqlite3 libsqlite3-dev
install memcached memcached
install Redis redis-server
install RabbitMQ rabbitmq-server

install 'PostgreSQL' postgresql postgresql-contrib

install 'Nokogiri dependencies' libxml2 libxml2-dev libxslt1-dev
install 'Blade dependencies' libncurses5-dev
install 'ExecJS runtime' nodejs

# Custom made
install 'nginx dependencies' libcurl4-openssl-dev

echo 'Getting keys'
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
install 'certificates and transport https' apt-transport-https ca-certificates

echo 'Add passenger apt repository'
sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger trusty main > /etc/apt/sources.list.d/passenger.list'

echo 'Update repositories'
apt-get update

install 'nginx + passenger' nginx-extras passenger

echo 'Installing rake gem'
gem install rake

echo 'Setting up Nginx configuration'
# include passenger configurations in nginx
sed -i 's/# include \/etc\/nginx\/passenger.conf;/include \/etc\/nginx\/passenger.conf;/g' /etc/nginx/nginx.conf
echo 'server {
       listen 3000;
        server_name poraqui_api.com;
        passenger_enabled on;
        passenger_app_env development;
        root /var/www/poraqui_api/public;

        access_log /var/www/poraqui_api/log/development.log;
        error_log /var/www/poraqui_api/log/development.log;

        error_page 500 502 503 504 /5xx.html;
        location = /5xx.html {
                alias /var/www/poraqui_api/public/;
        }
}' > /etc/nginx/sites-available/poraqui_api
ln -s /etc/nginx/sites-available/poraqui_api /etc/nginx/sites-enabled/
service nginx restart
service nginx reload
# Make box to autostart nginx
echo "sudo /etc/init.d/nginx start" | sudo tee -a /etc/rc.local


echo 'Installing gems'
(cd /var/www/poraqui_api && bundle install)

echo 'Installing imagemagick'
apt-get install -y imagemagick --fix-missing

echo 'Cleaning files'
apt-get -y autoremove
apt-get -y autoclean

# Needed for docs generation.
update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8


echo 'all set, rock on!'
