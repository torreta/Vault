# por ser una subcarpeta de un git mayor se creo con el comando
rails new pagoprueba-api --api -T --skip-git

# la aplicacion react la cree con 
 npx create-react-app pagoprueba-front

# le agrego react core (app)
https://material-ui.com/getting-started/installation/
 yarn add @material-ui/core


# link rails api devise (para autenticacion)
https://github.com/lynndylanhurley/devise_token_auth

gem 'devise_token_auth' 

alternativa 'knock'

# ---------- scafolds semi validos
rails new pagoprueba-api --api -T --skip-git
 
rails g scaffold profile cedula:integer name:string 

rails g scaffold bank name:string code:integer phone_registered:integer:uniq

rails g scaffold bank_account amount:float bank_id:references:bank

rails g transaction amount:float sender_account_id:references:bank_account receiver_account_id:references:bank_account sender_id:user_id:references receiver_id:user_id:references 
date:timestamp

# chuleta
:boolean
:date
:datetime
:float
:integer
:timestamps


# ref
https://material-ui.com/es/components/menus/

# commandos
> levantar en otro puerto (choca con npx)
rails s -p 3001 

> levantar el app con  (puerto 3000)
yarn start

# --------- Pantallas

 login - registro

 perfil

 boton logout

 tranferir

 transacciones

# seeds proximas

bank_list = [
  ["Banco Central de Venezuela","0001"]
  ["Banco Industrial de Venezuela, C.A. Banco Universal","0003"]
  ["Banco de Venezuela S.A.C.A. Banco Universal","0102"]
  ["Venezolano de Crédito, S.A. Banco Universal","0104"]
  ["Banco Mercantil, C.A S.A.C.A. Banco Universal","0105"]
  ["Banco Provincial, S.A. Banco Universal","0108"]
  ["Bancaribe C.A. Banco Universal","0114"]
  ["Banco Exterior C.A. Banco Universal","0115"]
  ["Banco Occidental de Descuento, Banco Universal C.A.","0116"]
  ["Banco Caroní C.A. Banco Universal","0128"]
  ["Banesco Banco Universal S.A.C.A.","0134"]
  ["Banco Sofitasa Banco Universal","0137"]
  ["Banco Plaza Banco Universal","0138"]
  ["Banco de la Gente Emprendedora C.A.","0146"]
  ["Banco del Pueblo Soberano, C.A. Banco de Desarrollo","0149"]
  ["BFC Banco Fondo Común C.A Banco Universal","0151"]
  ["100% Banco, Banco Universal C.A.","0156"]
  ["DelSur Banco Universal, C.A.","0157"]
  ["Banco del Tesoro, C.A. Banco Universal","0163"]
  ["Banco Agrícola de Venezuela, C.A. Banco Universal","0166"]
  ["Bancrecer, S.A. Banco Microfinanciero","0168"]
  ["Mi Banco Banco Microfinanciero C.A.","0169"]
  ["Banco Activo, C.A. Banco Universal","0171"]
  ["Bancamiga Banco Microfinanciero C.A.","0172"]
  ["Banco Internacional de Desarrollo, C.A. Banco Universal","0173"]
  ["Banplus Banco Universal, C.A.","0174"]
  ["Banco Bicentenario Banco Universal C.A.","0175"]
  ["Banco Espirito Santo, S.A. Sucursal Venezuela B.U.","0176"]
  ["Banco de la Fuerza Armada Nacional Bolivariana, B.U.","0177"]
  ["Citibank N.A.","0190"]
  ["Banco Nacional de Crédito, C.A. Banco Universal","0191"]
  ["Instituto Municipal de Crédito Popular","0601"]
]

bank_list.each do |name, code3, code2|
  Country.create( name: name, code: code3)
end

# install yarn 
yarn start