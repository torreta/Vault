async _verifyToken() {
  let token = await AsyncStorage.getItem("token");
  let conversation = await AsyncStorage.getItem("conversation");
  let redirect = await AsyncStorage.getItem("redirect");
  let aux_redirect = "";

  let query = API.url + "api/users/me/profile";

  return fetch(query, {
    method: "GET",
    headers: {
      "access-control-allow-headers":
        "Origin, X-Requested-With, Content-Type, Accept",
      "access-control-allow-origin": "*",
      "content-type": "application/json",
      Authorization: "Bearer " + token
    }
  })
    .then(response => response.json())
    .then(response => {
      // console.log("respuesta del server token auto");
      // console.log(response);
      var request = {};
      var user = response;
      request.user = user;
      request.token = token;

      //   // NOTA: HAY QUE SALVAR LA RESPUESTA DEL SERVER AQUI, SEMI PERMANENTE
      this.setUserAuthInfo(token);
      this.props.addUserInfo(request);
      // console.log("antes de conectar al socket");
      SocketUtils.ConnectedServer();
      SocketUtils.listChatsRecents();
      // console.log("despues de conectar al socket");

      // envio el id del del dispositivo
      ApiUtils.subscribe();

      //   // NOTA: Hacer un archivo aparte con las traducciones de strings
      //   // si el usuario no tiene intereses asociados
      if (user.interests.length < 3) {
        // Alert.alert(
        //   "Enhorabuena",
        //   "Login Exitoso con email! , pero debes introducir intereses."
        // );
        this.props.navigation.navigate("Interests");

        // si tiene acceso pero no tiene un grupo
      } else if (typeof user.group === "undefined") {
        // Alert.alert(
        //   "Enhorabuena",
        //   "Login Exitoso con email! , pero debes Unirte a un grupo."
        // );
        this.props.navigation.navigate("Groups");
      } else {
        // Alert.alert("Enhorabuena", "Login Exitoso con email!");
        this._loadConversations().then(
          this._loadNotifications().then(() => {
            if (typeof redirect !== "undefined" && redirect !== null) {
              // colocar la conversacion...
              aux_redirect = redirect;
              aux_conversation = conversation;
              //borro los valores del async storage
              AsyncStorage.removeItem("redirect");
              AsyncStorage.removeItem("conversation");

              //redirecciono a pantalla apropiada con return_to correcto

              if(aux_redirect == "ranking"){
                this.props.navigation.navigate("Notifications", {
                  return_to: "Tabs"
                })
              }
              if(aux_redirect == "chat"){
                this._redirectChat(aux_conversation);
              }
              if(aux_redirect == "group"){
                this.props.navigation.navigate("Tabs")
              }
            } else {
              this.props.navigation.navigate("Tabs")
            }
          })
        );
      }
    })

    .catch(error => {
      console.log("catch externo token return");
      console.log(JSON.stringify(error.message));

      if (error.message == "Network request failed") {
        console.log("estoy aqui, hola");
        this.setState({
          internetConnection: false
        });
      }
      // Alert.alert("Error Login", JSON.stringify(error.message));
      // Alert.alert("Error Login", "Problemas de conexion con el servidor");
      this.setState({
        isLoading: false
      });
    });
}