import API from "./api.js";
import {
  Image,
  AsyncStorage,
  ActivityIndicator,
  StyleSheet,
  View,
  Alert,
  Dimensions
} from "react-native";
import React, { Component } from "react";
import Moment from "moment";
import _ from "lodash";

import store from "../redux/store";

const { height, width } = Dimensions.get("window");

/*
 * Http requests to the API wrapper
 * Several utilities functions realated to the token, roles and app modes.
 */
export var ApiUtils = {
  checkStatus: async function (response, source = "default") {
    // console.log("Con el p-arametro custom default");
    // console.log(source);

    var error = false;
    var mensaje = "";

    // console.log("pinche response en checksattus");
    // console.log(response);

    if (response.status >= 200 && response.status < 300) {
      return response;
    } else {
      if (response.status >= 500 && response.status < 600) {
        console.log("error comunicacion con el servidor (checkstatus)");
        error = "server";
      }

      if (response.status == 400) {
        console.log("error de peticion con el servidor (checkstatus)");
        error = "request";
      }

      if (response.status == 401) {
        console.log("error autenticacion con el servidor (checkstatus)");
        error = "auth";
      }

      if (response.status == 422) {
        console.log("error autenticacion usuario (checkstatus)");
        error = "entity";
      }

      console.log("error especifico en el fetch (checkstatus)");
      // console.log(response);
      console.log(source);

      switch (source) {
        case "password":
          if (error == "request") {
            // el mensaje de error que me da el endpoint (email en uso)(registro)
            // NOTA: ESTE ERROR DEBERIA ESTAR FOMALITO POR EL MODULO DE TRADUCCIONES (?)
            await response.json().then(function (data) {
              throw new Error(data.message);
            })
          }
          break;
        case "register":
          if (error == "entity") {
            // NOTA: Errores de password de formato invalido tambien son 422
            //el mensaje de error que me da el endpoint (email en uso)(registro)
            console.log("estoy aqui?")
            await response.json().then(function (data) {
              // Alert.alert("Error", data.message);
              throw new Error(data.message);
            })
            // mensaje = JSON.parse(response._bodyInit).message;
            // // NOTA: ESTE ERROR DEBERIA ESTAR FOMALITO POR EL MODULO DE TRADUCCIONES
            // throw new Error(mensaje);
          }
          if (error == "request") {
            // console.log("CASO JOIN CHANNEL" +  JSON.stringify(response));
            await response.json().then(function (data) {
              // console.log("PROMESA TERMiNADA")
              // console.log(data)
              // Alert.alert("Error", data.message);
              throw new Error(data.message);
            })
          }
          break;
        case "login":
          if (error == "entity") {
            //el mensaje de error que me da el endpoint (email en uso)(registro)
            console.log("Estoy donde yo creo?");
            mensaje = JSON.parse(response._bodyInit).message;
            // NOTA: ESTE ERROR DEBERIA ESTAR FOMALITO POR EL MODULO DE TRADUCCIONES
            throw new Error(mensaje);
          }
          if (error == "request") {
            //el mensaje de error que me da el endpoint (email en uso)(registro)
            await response.json().then(function (data) {
              // console.log("PROMESA TERMiNADA")
              // console.log(data)
              // Alert.alert("Error", data.message);
              // throw new Promise.resolve({ type: "Error" , message: data.message });
              throw new Error(data.message);
              // throw data.message;
            })
          }
          break;
        case "facebook":
          if (error == "entity") {
            //el mensaje de error que me da el endpoint (email en uso)(registro)
            // mensaje = JSON.parse(response._bodyInit).message;
            // NOTA: ESTE ERROR DEBERIA ESTAR FOMALITO POR EL MODULO DE TRADUCCIONES
            // throw new Error(mensaje);
            await response.json().then(function (data) {
              throw new Error(data.message);
            });
          }
          if (error == "request") {
            //el mensaje de error que me da el endpoint (email en uso)(registro)
            // NOTA: ESTE ERROR DEBERIA ESTAR FOMALITO POR EL MODULO DE TRADUCCIONES
            // console.log("RESPONSE LITERAL DEL API DE REGRESO /SOCIAL")
            // mensaje = JSON.parse(response._bodyInit).message;
            // console.log(mensaje)
            // throw new Error(mensaje);
            await response.json().then(function (data) {
              throw new Error(data.message);
            });
          }
          break;
        case "joinChannel":
          if (error == "request") {
            // console.log("CASO JOIN CHANNEL" +  JSON.stringify(response));
            await response.json().then(function (data) {
              // console.log("PROMESA TERMiNADA")
              // console.log(data)
              // Alert.alert("Error", data.message);
              throw new Error(data.message);
            })
          }
          break;
        case "device_token":
          if (error == "request") {
            await response.json().then(function (data) {
              // Alert.alert("Error", data.message);
              throw new Error(data.message);
            })
          }
          break;
        case "default":
          if (error == "default")
            break;
          if (error == "server") {
            throw new Error("Error al obtener informacion");
          }
          if (error == "request") {
            await response.json().then(function (data) {
              throw new Error(data.message);
            })
          }
        default:
          console.log(
            "fuente de error desconocida " + source + " (checkstatus)"
          );
          break;
      }

      throw new Error(response);
    }
  },

  setToken: function (token) {
    AsyncStorage.removeItem("token");
    AsyncStorage.setItem("token", token);
  },

  getToken: async function () {
    return await AsyncStorage.getItem("token");
  },

  removeToken: function () {
    AsyncStorage.removeItem("token");
  },

  get: async function (url, body = {}, source = "default") {
    // let token = await AsyncStorage.getItem("token");
    let token = store.getState().authentication.token;

    return fetch(url, {
      method: "GET",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json",
        Authorization: "Bearer " + token
      }
    })
      .then(response => this.checkStatus(response, source))
      .then(response => response.json())
    // .catch(error => {
    //   console.log("cayo en el a ver porque get");
    //   console.log(error);
    // });
  },

  post: async function (url, body = {}, source = "default") {
    // let token = await AsyncStorage.getItem("token");
    let token = store.getState().authentication.token;

    return fetch(url, {
      method: "POST",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json; charset=utf-8",
        Authorization: "Bearer " + token
      },
      body: JSON.stringify(body)
    })
      .then(response => this.checkStatus(response, source))
      .then(response => response.json());
  },

  postOk: async function (url, body = {}, source = "default") {
    // let token = await AsyncStorage.getItem("token");
    let token = store.getState().authentication.token;
    // console.log("LO QUE MANDO")
    // console.log(JSON.stringify(body))

    return fetch(url, {
      method: "POST",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json; charset=utf-8",
        Authorization: "Bearer " + token
      },
      body: JSON.stringify(body)
    })
      .then(response => this.checkStatus(response, source));
  },

  put: async function (url, body = {}, source = "default") {
    // let token = await AsyncStorage.getItem("token");
    let token = store.getState().authentication.token;

    return fetch(url, {
      method: "PUT",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json",
        Authorization: "Bearer " + token
      },
      body: JSON.stringify(body)
    })
      .then(response => this.checkStatus(response, source))
      .then(response => response.json());
  },

  putOk: async function (url, body = {}, source = "default") {
    // let token = await AsyncStorage.getItem("token");
    let token = store.getState().authentication.token;

    return fetch(url, {
      method: "PUT",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json",
        Authorization: "Bearer " + token
      },
      body: JSON.stringify(body)
    })
      .then(response => this.checkStatus(response, source));
  },

  patch: async function (url, body = {}, source = "default") {
    // let token = await AsyncStorage.getItem("token");
    let token = store.getState().authentication.token;

    return fetch(url, {
      method: "PATCH",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json",
        Authorization: "Bearer " + token
      },
      body: JSON.stringify(body)
    })
      .then(response => this.checkStatus(response, source))
      .then(response => response.json());
  },

  patch: async function (url, body = {}, source = "default") {
    // let token = await AsyncStorage.getItem("token");
    let token = store.getState().authentication.token;

    return fetch(url, {
      method: "PATCH",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json",
        Authorization: "Bearer " + token
      },
      body: JSON.stringify(body)
    })
      .then(response => this.checkStatus(response, source));
  },

  delete: async function (url, body = {}, source = "default") {
    // let token = await AsyncStorage.getItem("token");
    let token = store.getState().authentication.token;

    return fetch(url, {
      method: "DELETE",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json; charset=utf-8",
        Authorization: "Bearer " + token
      },
      body: JSON.stringify(body)
    })
      .then(response => this.checkStatus(response, source))
      .then(response => response.json());
  },

  deleteOk: async function (url, body = {}, source = "default") {
    // let token = await AsyncStorage.getItem("token");
    let token = store.getState().authentication.token;

    return fetch(url, {
      method: "DELETE",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json; charset=utf-8",
        Authorization: "Bearer " + token
      },
      body: JSON.stringify(body)
    })
      .then(response => this.checkStatus(response, source));
  },

  acquireToken: async function () {
    return Keychain.getInternetCredentials(API.url)
      .then(credentials => {
        let email = credentials.username;
        let password = credentials.password;
        this._getTokenWithUserCredentials(email, password);
      })
      .catch(error => {
        this._getTokenWithClientCredentials();
      });
  },

  acquireTokenWithUserLogin: async function (email, password) {
    // let url = API.url + "authenticate";
    let url = API.url + "api/auth/sessions";

    return fetch(url, {
      method: "POST",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json; charset=utf-8"
      },
      body: JSON.stringify({
        email: _.trim(email),
        password: _.trim(password)
      })
    })
      .then(response => this.checkStatus(response, "login"))
      .then(response => response.json())
  },

  setUserGroup: async function (url, body = {}, source = "default") {
    // let url = API.url + "authenticate";
    // let token = await AsyncStorage.getItem("token");
    let token = store.getState().authentication.token;

    return fetch(url, {
      method: "POST",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json; charset=utf-8",
        Authorization: "Bearer " + token
      }
    })
      .then(response => this.checkStatus(response, source))
      .then(response => response.json());
  },

  acquireTokenWithUserRegister: async function (name, email, password) {
    // let url = API.url + "authenticate";
    let url = API.url + "api/users/";
    var RegisterAnswer = {};
    console.log("llamando al api al: " + url);

    console.log(
      JSON.stringify({
        name: name,
        email: email,
        password: password
      })
    );

    return fetch(url, {
      method: "POST",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json; charset=utf-8"
      },
      body: JSON.stringify({
        name: _.trim(name),
        email: _.trim(email),
        password: _.trim(password)
      })
    })
      .then(response => this.checkStatus(response, "register"))
      .then(response => response.json());
  },

  acquireTokenWithFacebookRegister: async function (facebookData) {
    let url = API.url + "api/users/social";
    console.log("llamando al api al: " + url);

    console.log(
      JSON.stringify(facebookData)
    );

    return fetch(url, {
      method: "POST",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json; charset=utf-8"
      },
      body: JSON.stringify(facebookData)
    })
      .then(response => this.checkStatus(response, "facebook"))
      .then(response => response.json());
  },

  acquireTokenWithFacebookLogin: async function (facebookData) {
    let url = API.url + "api/auth/sessions/social";
    console.log("llamando al api al: " + url);

    console.log(
      JSON.stringify(facebookData)
    );

    return fetch(url, {
      method: "POST",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json; charset=utf-8"
      },
      body: JSON.stringify(facebookData)
    })
      .then(response => this.checkStatus(response, "facebook"))
      .then(response => response.json());
  },

  saveUserToken: function (sresponse, email, password) {
    try {
      ApiUtils.setToken(response.auth_token);
      ApiUtils.setRoles(response.roles);
    } catch (error) {
      return this._getTokenWithClientCredentials();
    }

    Keychain.setInternetCredentials(API.url, email, password)
      .then(() => { })
      .catch(error => { })
      .done();
  },

  acquireTokenWithClient: async function () {
    let url = API.url + "authenticate";

    return fetch(url, {
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json"
      },
      body: JSON.stringify({
        client_uid: API.client_uid
      })
    })
      .then(this.checkStatus)
      .then(response => response.json())
      .then(response => this._requestSuccessClient(response))
      .catch(error => {
        Alert.alert(
          "Error",
          "There was an error trying to connect with the server. Please try later. during fetch on client data"
        );
      });
  },

  saveClientToken: function (response) {
    try {
      ApiUtils.setToken(response.auth_token);
      // ApiUtils.cleanRoles();
    } catch (error) {
      Alert.alert(
        "Error",
        "There was an error trying to connect with the server. Please try later. error saving the usertoken"
      );
    }
  },

  deleteToken: async function () {
    AsyncStorage.removeItem("token");
  },

  subscribe: async function () {
    let push_token = null;

    try {
      push_token = await AsyncStorage.getItem("push_token");
    } catch{
      console.log("push_token vacio para el subscribe, ignoro enviarlo");
    }

    console.log("supuestamente tengo un valor a subscribir");
    if (!push_token) {
      console.log("push_token esta vacio tiene: " + push_token + " evitando subscripcion");
      return;
    }

    let token = store.getState().authentication.token;
    let url = API.url + "api/users/notifications/subscription";
    let body = { deviceId: push_token };

    return fetch(url, {
      method: "POST",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json; charset=utf-8",
        Authorization: "Bearer " + token
      },
      body: JSON.stringify(body)
    })
      .then(response => this.checkStatus(response, "subscribe"))
      .then(response => {
        console.log("Se envio token a api");
        console.log("ID USER");
        console.log(store.getState().authentication.user.id);

        // if (response.status === 201) {

        //   // this.props.navigation.navigate("UserConfig");
        //   ApiUtils.postOk(API.url + "api/users/notifications/user/" + store.getState().authentication.user.id, { message: { notification: { title: "valgo", body: "veo", sound: "default" } } })
        //     .then(response => {

        //       // // si tiene acceso pero no tiene un grupo
        //       console.log("lo que respondio a lo de las notificaciones ")
        //       console.log(response)

        //       // if (response.status === 201) {
        //       // Alert.alert("Se envio token a api");
        //       // this.props.navigation.navigate("UserConfig");




        //       // } else {
        //       //   Alert.alert("No se pudo enviar debido a un error, intentelo de nuevo");
        //       // }
        //     })

        // } else {
        //   console.log("No se pudo enviar token devise ");
        // }
      })

  },

  unSubscribe: async function () {
    let push_token = await AsyncStorage.getItem("push_token");
    let token = store.getState().authentication.token;
    let url = API.url + "api/users/notifications/subscription";
    let body = { deviceId: push_token };

    return fetch(url, {
      method: "DELETE",
      headers: {
        "access-control-allow-headers":
          "Origin, X-Requested-With, Content-Type, Accept",
        "access-control-allow-origin": "*",
        "content-type": "application/json; charset=utf-8",
        Authorization: "Bearer " + token
      },
      body: JSON.stringify(body)
    })
      .then(response => this.checkStatus(response, "unsubscribe"))
      .then(response => {
        console.log("Se desuscribio al user de las push");
        console.log("ID USER");
        console.log(store.getState().authentication.user.id);
      })

  },
};
