
**PLANTILLA PARA LA DOCUMENTACION DE LLAMADAS**

**Titulo**
----
  <_Información adicional sobre las llamadas al api, intenta usar verbos que concuerden con el tipo de peticion (solicitar o modificar) y pluralidad (una vs multiples)_>


* **URL**

  <_La Estructura del URL (solamente ruta, sin la url de la raiz)_>


* **Metodo:**

  <_Tipo de solicitud_>

  `GET` | `POST` | `DELETE` | `PUT`

*  **Parametros URL**

   <_Si parametros de URL existen, especificarlos de acuerdo con el nombre mencionado en la seccion anterior, separados si son necesarios o requeridos, documenta restricciones de estos datos._>

   **Requeridos:**

   `id=[integer]`

   **Opcionales:**

   `photo_id=[alphanumeric]`

* **Datos Parametros**

  <_Si por ejemplo hacers una llamada post, los datos del payload como deberian verse? las reglas de los parametros aplican aqui tambien._>


* **Respuesta Exitosa:**

  <_En caso de una llamada exitosa que datos deberian llegar como respuesta? esto es util para las personas sepan que deberian esperar_>

  * **Codigo:** 200 <br />
    **Contenido:** `{ id : 12 }`

* **Respuesta Error:**

  <_La mayoria de las llamadas pueden fallar, desde acceso desautorizado, a parametros incorrectos, etc. Todos esos escenarios deberian listarse aqui, parecera repetitivo, pero previene que se asuman cosas sobre el comportamiento del api._>

  * **Codigo:** 401 UNAUTHORIZED <br />
    **Contenido:** `{ error : "Log in" }`

  OR

  * **Codigo:** 422 UNPROCESSABLE ENTRY <br />
    **Contenido:** `{ error : "Email Invalid" }`

* **Solicitud Ejemplo:**

  <_Llamada ejemplo de tu endpoint en un formato ejecutable (ajax o curl) esto hace mas facil y predecible el comportamiento._>

* **Notas:**

  <_Aqui es donde todas las comentarios, discusiones, etc. pueden plantearse. recomiendo dejar la fecha de la duda con el comentario al dejar cosas aqui._>




------
**Mostrar Perfil**
------
  Regresa un json con los datos asociados al usuario.

* **URL**

  /profiles/:id

* **Metodo:**

  `GET`

*  **Parametros URL**

  **Requeridos:**

   `id=[integer]`

* **Datos Parametros**

   No aplica

 * **Respuesta Exitosa:**

 * **Codigo:** 200 ok <br />
   **Contenido:**
             `{
                 "id": 2,
                 "name": "juan",
                 "last_name": "apellido",
                 "best_score": 0,
                 "email_verified": false,
                 "gender_id": 1,
                 "status_id": 2,
                 "role_id": 3,
                 "country_id": 208,
                 "created_at": "2017-12-14T15:29:25.000Z",
                 "updated_at": "2017-12-14T15:29:25.000Z",
                 "image_file_name": null,
                 "image_content_type": null,
                 "image_file_size": null,
                 "image_updated_at": null,
                 "email": "correo@gmail.com",
                 "role": "Player",
                 "status": "Probando",
                 "gender": "FEMENINO",
                 "country": "Spain "
             }`

 * **Respuesta Error:**


  * **Codigo:** 404 NOT FOUND <br />
    **Contenido:** `{ error : "El usuario no existe." }`

  OR

  * **Codigo:** 401 UNAUTHORIZED <br />
    **Contenido:** `{ error : "Debes estar autenticado para solicitar información." }`

  * **Solicitud Ejemplo:**

      (ver postman)


------
**Actualizar Perfil**
------
  Recibe lista de parámetros para actualizar los datos del perfil.

* **URL**

  /profiles/:id

* **Metodo:**

  `PUT`

*  **Parametros URL**

  **Requeridos:**

   `id=[integer]`

* **Datos Parametros**

    `{
       "email"=>"email@gmail.com",
       "password"=>"contraseña",
       "name"=>"nombre nuevo",
       "last_name"=>"apellido nuevo",
       "gender_id"=>"2",
       "country_id"=>"3",
       "id"=>"2",
       "image":
       {
            "name": "default_avatar.jpg",
            "content_type": "image/jpg",
            "data": "/9j/4AA"  <- Imagen en Base64
        }
    }`


 * **Respuesta Exitosa:**

 * **Codigo:** 200 pk <br />
   **Contenido:**
       `{
           "id": 2,
           "name": "juan",
           "last_name": "apellido",
           "best_score": 0,
           "email_verified": false,
           "gender_id": 1,
           "status_id": 2,
           "role_id": 3,
           "country_id": 208,
           "created_at": "2017-12-14T15:29:25.000Z",
           "updated_at": "2017-12-14T15:29:25.000Z",
           "image_file_name": null,
           "image_content_type": null,
           "image_file_size": null,
           "image_updated_at": null,
           "email": "correo@gmail.com",
           "role": "Player",
           "status": "Probando",
           "gender": "FEMENINO",
           "country": "Spain "
       }`

 * **Respuesta Error:**


  * **Codigo:** 400 UNPROCESSABLE ENTITY <br />
    **Contenido:** `{ error : "Error actualizando el usuario." }`

  OR

  * **Codigo:** 401 UNAUTHORIZED <br />
    **Contenido:** `{ error : "Debes estar autenticado para solicitar información." }`

  * **Solicitud Ejemplo:**

      (ver postman)


------
**Registrar Usuario**
------
  Recibe lista de parámetros para registrar un nuevo usuario

* **URL**

  /auth

* **Metodo:**

  `POST`

*  **Parametros URL**

  **Requeridos:**

    `email=[alfanumerico]`       (correo)
    `password=[alfanumerico]`    (contraseña)

  **Opcionales:**

    `name=[alfanumerico]`        (nombre)
    `last_name=[alfanumerico]`   (apellido)
    `nickname=[alfanumerico]`    (si no especificas, por defecto coloca el nombre)

* **Datos Parametros**

    `{
       "email"=>"email@gmail.com",
       "password"=>"contraseña",
       "name"=>"nombre",
       "last_name"=>"apellido",
       "nickname"=>"nickname",
    }`


 * **Respuesta Exitosa:**

 * **Codigo:** 200 pk <br />
   **Contenido:**
       `{
          "data": {
            "id": 5,
            "email": "email@gmail.com",
            "uid": "email@gmail.com",
            "provider": "email|facebook",
            "name": nombre,
            "nickname": nickname,
            "image": null,
            "profile_id": 5
            }
          }`
          + headers: (especificados en las notas.)

 * **Respuesta Error:**


  * **Codigo:** 400 UNPROCESSABLE ENTITY <br />
    **Contenido:** `{ error : "Error missing parameters." }`


  * **Solicitud Ejemplo:**

      (ver postman)

  * **Notas**

    <_los campos a continuacion son Headers HTTP, se deben pasar para que el API, en cada solicitud, pueda identificar al usuario_>
      * **access-token:** (Hash alfanumerico)
      * **client:** (Hash alfanumerico)
      * **expiry:** (alfanumerico, timestamp)
      * **uid:** Hash alfanumerico (facebook) | email (registro local)

      <_uid= dependiendo del metodo de registro, este campo sera un hash alfanumerico si el cliente proviene de facebook, sino, sera el correo del usuario_>

      <_de aqui en adelante si la solicitud menciona que requiere un usuario autenticado, nos referimos a que la peticion / solicitud al api necesita incluir en los header HTTP, los 4 campos anteriormente mencionados_>



  ------
  **Autenticar Usuario**
  ------
    Recibe lista de parámetros para Autenticar al usuario (login)

  * **URL**

    /auth/sign_in

  * **Metodo:**

    `POST`

  *  **Parametros URL**

    **Requeridos:**

      `email=[alfanumerico]`       (correo)
      `password=[alfanumerico]`    (contraseña)

  * **Datos Parametros**

      `{
         "email"=>"email@gmail.com",
         "password"=>"contraseña",
      }`


   * **Respuesta Exitosa:**

   * **Codigo:** 200 pk <br />
     **Contenido:**
         `{
            "data": {
              "id": 5,
              "email": "pedrazo@gmail.com",
              "uid": "pedrazo@gmail.com",
              "provider": "email",
              "name": null,
              "nickname": null,
              "image": null,
              "profile_id": 5
              }
            }`
            + headers: (especificados en las notas.)

   * **Respuesta Error:**


    * **Codigo:** 400 UNPROCESSABLE ENTITY <br />
      **Contenido:** `{ error : "Error missing parameters." }`

    OR

    * **Codigo:** 401 UNAUTHORIZED <br />
      **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

    * **Solicitud Ejemplo:**

        (ver postman)

    * **Notas**

      <_los campos a continuacion son Headers HTTP, se deben pasar para que el API, en cada solicitud, pueda identificar al usuario_>
        * **access-token:** (Hash alfanumerico)
        * **client:** (Hash alfanumerico)
        * **expiry:** (alfanumerico, timestamp)
        * **uid:** Hash alfanumerico (facebook) | email (registro local)

        <_uid= dependiendo del metodo de registro, este campo sera un hash alfanumerico si el cliente proviene de facebook, sino, sera el correo del usuario_>

        <_de aqui en adelante si la solicitud menciona que requiere un usuario autenticado, nos referimos a que la peticion / solicitud al api necesita incluir en los header HTTP, los 4 campos anteriormente mencionados_>

        <_la llamada de autenticar y registrar son similares, ambas regresan los datos de los usuarios, piden los mismos parametros, pero tienen endpoints distintos_>



    ------
    **Comprobar Tokens**
    ------
      Recibe los headers derivados de la autenticacion, comprueba si son validos y su expiración. (requiere usuario autenticado)

    * **URL**

      /auth/validate_token

    * **Metodo:**

      `GET`

    *  **Parametros URL**

      **Requeridos:**

        *no requiere*

    * **Datos Parametros**

        *no requiere*

     * **Respuesta Exitosa:**

     * **Codigo:** 200 pk <br />
       **Contenido:**
           `{
              "data": {
                "id": 5,
                "email": "pedrazo@gmail.com",
                "uid": "pedrazo@gmail.com",
                "provider": "email",
                "name": null,
                "nickname": null,
                "image": null,
                "profile_id": 5
                }
              }`
              + headers

     * **Respuesta Error:**

      * **Codigo:** 401 UNAUTHORIZED <br />
        **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

      * **Solicitud Ejemplo:**

          (ver postman)

      * **Notas**

          <_este metodo es espeficicamente para que la aplicación guarde los header de autenticación, y de este modo el usuario no tenga que colocar siempre su usuario y contraseña, sino que compruebe si los token siguen siendo validos y de este modo evitar volver a colocar usuario y contraseña manualmente desde la aplicación_>



  ------
  **Autenticar / Registrar Usuario Facebook**
  ------
    Recibe los datos provenientes de la aplicación de facebook para conceder la autenticación, si el usuario existe, retorna los datos del usuario + tokens e ignora los parametros Opcionales, si el usuario no esta registrado lo registra en el api y usa la informacion de los parametros opcionales para modificar la información por defecto del perfil.

  * **URL**

    /facebook

  * **Metodo:**

    `POST`

  *  **Parametros URL**

    **Requeridos:**

      `email=[alfanumerico]`       (correo)
      `uid=[alfanumerico]`         (hash facebook id)
      `provider=facebook`          (por ahora, solo facebook, en el futuro quizas twitter, etc)

    **Opcionales:**

    `name=[alfanumerico]`          (nombre del usuario)
    `sexo=[caracter]`              (genero) (un solo caracter F o M)
    `image=[url]`                  (url de la foto de perfil del usuario en facebook)

  * **Datos Parametros**

  `{
      "email": "correo@gmail.com",
      "uid": "hashquenoverificoquepuedesertotalmentefalso",
      "provider":"facebook",
      "name":"nombre",
      "sexo":"F",
      "image":"https://www.urlancestral/photo"
   }`

   * **Respuesta Exitosa:**

   * **Codigo:** 200 pk <br />
     **Contenido:**
           `{
              "uid": "superhashquenotengoniideadedondesaleparte2",
              "email": "alfredaespro@gmail.com",
              "id": 3,
              "provider": "facebook",
              "created_at": "2017-12-12T22:26:28.000Z",
              "updated_at": "2017-12-15T17:56:46.000Z",
              "name": null,
              "nickname": null,
              "image": null,
              "profile_id": 4
            }`
            + headers

   * **Respuesta Error:**

    * **Codigo:** 401 UNAUTHORIZED <br />
      **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

      OR

    * **Codigo:** 400  <br />
      **Contenido:** `{ "mensaje": "parametros incompletos."  }`

    * **Solicitud Ejemplo:**

        (ver postman)

    * **Notas**

        <_este metodo dificilmente genera error por su flexibilidad, el token no esta siendo verificado contra el api de facebook, asi que usar este endpoint con cautela, bueno, gracias a lo flexible que es quizas en un futuro se pueda usar para autenticar contra twitter y paginas similares_>



    ------
    **Destruir Sesion**
    ------

      Recibe los datos del token de usuario y borra la session del usuario. (requiere tokens)

    * **URL**

      /auth/sign_out

    * **Metodo:**

      `DELETE`

    *  **Parametros URL**

      **Requeridos:**

        *no requiere*

      **Opcionales:**

        *no posee*

    * **Datos Parametros**

        *no requiere*

     * **Respuesta Exitosa:**

     * **Codigo:** 200 pk <br />
       **Contenido:**
             `{
                "uid": "superhashquenotengoniideadedondesaleparte2",
                "email": "alfredaespro@gmail.com",
                "id": 3,
                "provider": "facebook",
                "created_at": "2017-12-12T22:26:28.000Z",
                "updated_at": "2017-12-15T17:56:46.000Z",
                "name": null,
                "nickname": null,
                "image": null,
                "profile_id": 4
              }`
              + headers

     * **Respuesta Error:**

      * **Codigo:** 401 UNAUTHORIZED <br />
        **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

        OR

      * **Codigo:** 400  <br />
        **Contenido:** `{ "mensaje": "parametros incompletos."  }`

      * **Solicitud Ejemplo:**

          (ver postman)

      * **Notas**

          <_este metodo dificilmente genera error por su flexibilidad, el token no esta siendo verificado contra el api de facebook, asi que usar este endpoint con cautela, bueno, gracias a lo flexible que es quizas en un futuro se pueda usar para autenticar contra twitter y paginas similares_>


    ------
    **Recordar contraseña**
    ------

      Resetea la contraseña de un cliente si esta se le olvida, y le envia un correo con una contraseña temporal para poder acceder a la aplicación y cambiar su contraseña por los medios regulares.

    * **URL**

      /auth/password

    * **Metodo:**

      `POST`

    *  **Parametros URL**

      **Requeridos:**

      `email=[alfanumerico]`            (correo)
      `redirect_url=#`                  (#)

    * **Datos Parametros**

        *no requiere*

     * **Respuesta Exitosa:**

     * **Codigo:** 200 pk <br />
       **Contenido:**
             `{
                  "success": true,
                  "message": "An email has been sent to 'lcampos@strix.com.ve' containing instructions for resetting your password."
              }`
              + headers

     * **Respuesta Error:**

      * **Codigo:** 401 UNAUTHORIZED <br />
        **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

        OR

      * **Codigo:** 400  <br />
        **Contenido:** `{ "mensaje": "parametros incompletos."  }`

      * **Solicitud Ejemplo:**

          (ver postman)

      * **Notas**

          <_por ahora el parametro redirect_url a pesar de ser obligatorio, es ignorado, este parametro sera en un futuro usado con el proposito de seguir convenciones de oauth y sistemas similares de autenticacion tercerizada_>



    ------
    **Cambiar contraseña**
    ------

      Cambia la contraseña de un usuario. (requiere tokens)

    * **URL**

      /auth/password

    * **Metodo:**

      `PUT`

    *  **Parametros URL**

      **Requeridos:**

      `password=[alfanumerico]`               (contraseña)
      `password_confirmation=[alfanumerico]`  (contraseña)

    * **Datos Parametros**

        *no requiere*

     * **Respuesta Exitosa:**

     * **Codigo:** 200 pk <br />
       **Contenido:**
             `{
                  "success": true,
                  "data": {
                      "id": 17,
                      "provider": "email",
                      "email": "lcampos@strix.com.ve",
                      "uid": "lcampos@strix.com.ve",
                      "created_at": "2017-12-18T04:49:55.000Z",
                      "updated_at": "2017-12-18T04:58:59.000Z",
                      "name": null,
                      "nickname": null,
                      "image": null,
                      "profile_id": null
                  },
                  "message": "Your password has been successfully updated."
              }`
              + headers

     * **Respuesta Error:**

      * **Codigo:** 401 UNAUTHORIZED <br />
        **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

        OR

      * **Codigo:** 400  <br />
        **Contenido:** `{ "mensaje": "parametros incompletos."  }`

      * **Solicitud Ejemplo:**

          (ver postman)


    ------
    **Listar Modods de Juego**
    ------

      Pregunta por los modos de juego de la aplicación. (requiere tokens)

    * **URL**

      /modes

    * **Metodo:**

      `GET`

    *  **Parametros URL**

        *no requiere*

    * **Datos Parametros**

        *no requiere*

     * **Respuesta Exitosa:**

     * **Codigo:** 200 pk <br />
       **Contenido:**
             `[
                  {
                      "id": 1,
                      "name": "Individual",
                      "created_at": "2017-11-28T16:34:20.000Z",
                      "updated_at": "2017-11-28T16:34:20.000Z"
                  },
                  {
                      "id": 2,
                      "name": "Multijugador",
                      "created_at": "2017-11-28T16:34:20.000Z",
                      "updated_at": "2017-11-28T16:34:20.000Z"
                  }
              ]`
              + headers

     * **Respuesta Error:**

      * **Codigo:** 401 UNAUTHORIZED <br />
        **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

      * **Solicitud Ejemplo:**

          (ver postman)


    ------
    **Listar Categorias**
    ------

      Pregunta por las Categorias de la aplicación. (requiere tokens)

    * **URL**

      /categories

    * **Metodo:**

      `GET`

    *  **Parametros URL**

        *no requiere*

    * **Datos Parametros**

        *no requiere*

     * **Respuesta Exitosa:**

     * **Codigo:** 200 pk <br />
       **Contenido:**
             `[
                {
                    "id": 1,
                    "name": "FÚTBOL",
                    "created_at": "2017-11-28T16:34:20.000Z",
                    "updated_at": "2017-11-28T16:34:20.000Z",
                    "image_file_name": null,
                    "image_content_type": null,
                    "image_file_size": null,
                    "image_updated_at": null
                },
                {
                    "id": 2,
                    "name": "BALONCESTO",
                    "created_at": "2017-11-28T16:34:20.000Z",
                    "updated_at": "2017-11-28T16:34:20.000Z",
                    "image_file_name": null,
                    "image_content_type": null,
                    "image_file_size": null,
                    "image_updated_at": null
                }
            ]`
              + headers

     * **Respuesta Error:**

      * **Codigo:** 401 UNAUTHORIZED <br />
        **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

      * **Solicitud Ejemplo:**

          (ver postman)


    ------
    **Mostrar Categoria**
    ------

      Pregunta por los datos de una Categoria espeficica de la aplicación. (requiere tokens)

    * **URL**

      /categories/:id

    * **Metodo:**

      `GET`

    *  **Parametros URL**

       `id=[integer]`

    * **Datos Parametros**

        *no requiere*

     * **Respuesta Exitosa:**

     * **Codigo:** 200 pk <br />
       **Contenido:**
             `{
                  "id": 1,
                  "name": "FÚTBOL",
                  "created_at": "2017-11-28T16:34:20.000Z",
                  "updated_at": "2017-11-28T16:34:20.000Z",
                  "image_file_name": null,
                  "image_content_type": null,
                  "image_file_size": null,
                  "image_updated_at": null
              }`
              + headers

     * **Respuesta Error:**

      * **Codigo:** 401 UNAUTHORIZED <br />
        **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

      * **Solicitud Ejemplo:**

          (ver postman)



    (DOCUMENTACION en progreso aqui en adelante)


    ------
    **Mostrar Compra de la aplicación**
    ------

      Pregunta por el estado del usuario. (inactivo, probando o pagado/activo) (requiere tokens)

    * **URL**

      /purchase

    * **Metodo:**

      `GET`

    *  **Parametros URL**

        *no requiere*

    * **Datos Parametros**

        *no requiere*

     * **Respuesta Exitosa:**

     * **Codigo:** 200 pk <br />
       **Contenido:**
             `{
                  "id": 1,
                  "name": "FÚTBOL",
                  "created_at": "2017-11-28T16:34:20.000Z",
                  "updated_at": "2017-11-28T16:34:20.000Z",
                  "image_file_name": null,
                  "image_content_type": null,
                  "image_file_size": null,
                  "image_updated_at": null
              }`
              + headers

     * **Respuesta Error:**

      * **Codigo:** 401 UNAUTHORIZED <br />
        **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

      * **Solicitud Ejemplo:**

          (ver postman)

    ------
    **Actualizar info de Compra de la aplicación**
    ------

      actualiza el estado del usuario, por el que se especifica en el campo estado de los parametros. (inactivo, probando o pagado/activo)  (requiere tokens)

    * **URL**

      /purchase

    * **Metodo:**

      `PUT`

    *  **Parametros URL**

      `estado=[inactivo/pagado/probando]`   (estado) (string alfanumerico)

    * **Datos Parametros**

        *no requiere*

     * **Respuesta Exitosa:**

     * **Codigo:** 200 pk <br />
       **Contenido:**
             `{
                  "id": 1,
                  "name": "FÚTBOL",
                  "created_at": "2017-11-28T16:34:20.000Z",
                  "updated_at": "2017-11-28T16:34:20.000Z",
                  "image_file_name": null,
                  "image_content_type": null,
                  "image_file_size": null,
                  "image_updated_at": null
              }`
              + headers

     * **Respuesta Error:**

      * **Codigo:** 401 UNAUTHORIZED <br />
        **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

      * **Solicitud Ejemplo:**

          (ver postman)


    ------
    **Agregar/Crear Puntuación al usuario de partida**
    ------

      crea una entrada de puntuacion al usuario, si esta resulta ser mayor a su mejor puntuacion anterior, la sustituye (requiere tokens)

    * **URL**

      /score

    * **Metodo:**

      `POST`

    *  **Parametros URL**

      **Requeridos:**

        `category_id=[integer]`   (el identificador de categoria)
        `level_id=[integer]`      (el identificador de nivel)
        `score=[integer]`         (Puntuación obtenida en la partida)

      **Opcionales:**

        `user_level_id=[integer]` (el identificador de nivel a actualizar al usuario)

    * **Datos Parametros**

        {
          "category_id": "1",
          "level_id": "1",
          "score": "131",
          "user_level_id":"2"
        }

     * **Respuesta Exitosa:**

     * **Codigo:** 200 pk <br />
       **Contenido:**
             `{
                  "id": 13,
                  "user_id": 5,
                  "category_id": 1,
                  "level_id": 1,
                  "score": 131,
                  "created_at": "2017-12-21T18:34:00.000Z",
                  "updated_at": "2017-12-21T18:34:00.000Z",
                  "mode_id": 1
              }`
              + headers

     * **Respuesta Error:**

      * **Codigo:** 401 UNAUTHORIZED <br />
        **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`

        OR

      * **Codigo:** 400  <br />
        **Contenido:** `{ "mensaje": "parametros incompletos."  }`

      * **Solicitud Ejemplo:**

          (ver postman)


    ------
    **Consultar Ranking de Usuarios**
    ------

      Pregunta por el ranking de los usuarios (requiere tokens)

    * **URL**

      /rankings

    * **Metodo:**

      `GET`

    *  **Parametros URL**

      **Opcionales:**

        `limit=[integer]`     (cantidad de jugadores con las mejores puntuaciones en orden decreciente)

    * **Datos Parametros**

      *no requiere*

     * **Respuesta Exitosa:**

     * **Codigo:** 200 pk <br />
       **Contenido:**
             `{
                "ranking": [
                    {
                        "id": 5,
                        "name": "Pedro",
                        "last_name": "montaner",
                        "best_score": 131,
                        "email_verified": false,
                        "gender_id": 1,
                        "status_id": 3,
                        "role_id": 3,
                        "country_id": 208,
                        "created_at": "2017-12-13T17:27:32.000Z",
                        "updated_at": "2017-12-21T15:21:03.000Z",
                        "image_file_name": null,
                        "image_content_type": null,
                        "image_file_size": null,
                        "image_updated_at": null,
                        "level_id": 2
                    },
                    {
                        "id": 1,
                        "name": "Luis",
                        "last_name": "Campos",
                        "best_score": 0,
                        "email_verified": false,
                        "gender_id": 1,
                        "status_id": 2,
                        "role_id": 3,
                        "country_id": 208,
                        "created_at": "2017-12-12T19:11:17.000Z",
                        "updated_at": "2017-12-12T19:11:17.000Z",
                        "image_file_name": null,
                        "image_content_type": null,
                        "image_file_size": null,
                        "image_updated_at": null,
                        "level_id": 1
                    }
                ],
                "user": {
                    "id": 5,
                    "name": "Pedro",
                    "last_name": "montaner",
                    "best_score": 131,
                    "email_verified": false,
                    "gender_id": 1,
                    "status_id": 3,
                    "role_id": 3,
                    "country_id": 208,
                    "created_at": "2017-12-13T17:27:32.000Z",
                    "updated_at": "2017-12-21T15:21:03.000Z",
                    "image_file_name": null,
                    "image_content_type": null,
                    "image_file_size": null,
                    "image_updated_at": null,
                    "level_id": 2
                }
            }`
            + headers

     * **Respuesta Error:**

      * **Codigo:** 401 UNAUTHORIZED <br />
        **Contenido:** `{ "errors": [ "Invalid login credentials. Please try again." ] }`


      * **Solicitud Ejemplo:**

          (ver postman)






