# instalación del docker para correr laravel

1. Se debe ir a la carpeta donde se tenga el archivo dockerfile y correr el siguiente comando

        docker image build -t laravel .

2. Luego se debe crear el contenedor a partir de la imagen que se acaba de correr, se puede hacer de la siguiente manera (Nota: Se puede cambiar el $(pwd) por una ruta en especifica ya que esta utiliza la ruta actual en la que se corra el comando)

        docker run -d -v $(pwd):/root/Code -p 8001:8000 --name go_pharma -it laravel bash

3. Ingresar al contenedor y poder iniciar el proyecto

        docker exec -it go_pharma bash

4. al ingresar al contenedor se ubicara en la carpeta /root/code del contenedor, en esta misma carpeta debe estar el poyecto y para iniciarlo se debe hacer lo siguiente

        cd projects/goPharma/admin/
        composer install
        php artisan serve --host 0.0.0.0