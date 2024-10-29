### IV. Configurar systemctl
1. En la raíz del proyecto ```pos_api/``` crear un archivo .sh llamado "run_pos_api.sh" que va a contener la siguiente información
```
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

npm run dev
```
2. Navegar a la carpeta ```/etc/systemd/system/``` y crear un archivo .service llamado ```pos_api.service``` que va a contener la siguiente información. Debe cambiar el final del label "ExecStart" y poner la ruta donde se encuentra el archivo run_pos_api.sh (Puede utilizar pwd para ello)

```
[Unit]
Description=POS API
Requires=network.target
Requires=mysql.service
After=network.target

[Service]
Environment=NODE_PORT=3000
EnvironmentFile=/home/usuario/.bashrc
Type=simple
WorkingDirectory=/home/usuario/pos_api
User=usuario
ExecStart=/bin/bash /home/usuario/pos_api/run_pos_api.sh
TimeoutSec=30
RestartSec=15s
Restart=always

[Install]
WantedBy=multi-user.target
```

3. Debe recargar el servicio systemctl con el siguiente comando
```
systemctl daemon-reload
```
4. Habilitar el nuevo servicio
```
sudo systemctl enable pos_api.service
```
5. Habilitar el nuevo servicio
```
sudo systemctl start pos_api.service
```

6. Verificar el estado del nuevo servicio, afirmando que esté corriendo con el mensaje de confirmación de la aplicación "SERVER UP!!!"
```
sudo systemctl start pos_api.service
```