Strix ERP v0.9
=

#### Create log files

* `touch /app/tmp/includes.ini`

* `touch /app/services/temp.log`

* `touch /app/tmp/modelLogs.log`


#### Create Database
* run `/app/sql/migrate.sh`

#### Create config file   
* `cp /app/vendors/AppConfig.php.example /app/vendors/AppConfig.php`
* Edit user,password, and database settings

#### Vagrant
If you decide to use vagrant instead of a local setup, follow this steps:
1. Install [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. Install [Vagrant](https://www.vagrantup.com/downloads.html)
2.1. If you are using [OpenSuse](https://alexvenn.wordpress.com/2016/03/25/getting-started-with-vagrant-on-opensuse-leap-42-1/):
    * `zypper in qemu libvirt libvirt-devel qemu-kvm libvirt libvirt-devel`
    * `systemctl enable libvirtd`
    * `systemctl start libvirtd`
    * Follow this [link](https://gist.github.com/hayderimran7/7f985276560395b9b8e0) or [this one](https://gattaca.es/post/running-vagrant-on-opensuse/) if the installation presented any errors 
3. `vagrant up`
3.1 if step 3. did not work, type `vagrant reload --provision`
* Use the ip 192.168.50.4 or localhost:8080 to access the webserver
