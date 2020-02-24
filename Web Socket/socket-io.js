import io from "socket.io-client/dist/socket.io";
import API from "./api";
import { ApiUtils } from "./apiUtils";

import store from "../redux/store";
import { userActions, listConversationsActions } from "../redux/actions";
import { listConversations } from "../redux/reducers/listConversationsReducer";

let socket;

function ConnectedServer() {
  socket = io(API.socket_url, {
    query: { token: store.getState().authentication.token },
    jsonp: false
    // jsonp: false, transports: ["websocket"], autoConnect: false, timeout: 10000,
  });

  socket.on("connect", function (response) {
    console.log("Conecte al socket");
    // console.log(response);
    store.dispatch(userActions.connectionStatus(true));

    socket.emit("join", { conversationId: "recents" }, function (response) {
      if (response.status_code === 200) {
        console.log("conexión exitosa al canal recientes");
      } else {
        console.log("Ocurrio un error");
      }
    });
    socket.on('reconnect', () => {
      ApiUtils.get(`${API.url}api/conversations/allChannelSimple`)
        .then(data => {
          //console.log("haciendo el fetch de las conversaciones", data);
          store.dispatch(listConversationsActions.setConversations(data.conversations));
        })
        .catch(error => {
          console.log(error);
        });

      ApiUtils.get(`${API.url}api/scorings/new`)
        .then(data => {
          //console.log("haciendo el fetch de las notificaciones", data);
          store.dispatch(userActions.newNotification(data.newScorings));
        })
        .catch(error => {
          console.log(error);
        });

    });
  });
}

function JoinChat(id) {
  socket.emit("join", { conversationId: id }, response => {
    response.status_code === 200
      ? console.log("Sin errores al entrar al chat")
      : console.log("Error al entrar al chat");
  });
}

function CloseChat(id) {
  socket.emit("leave", { conversationId: id }, response => {
    response.status_code === 200
      ? console.log("Sin errores al salir del chat")
      : console.log("Error al salir del chat");
  });
}

function SendMessage(params) {
  console.log(params);
  socket.emit("createMessage", params, response => {
    console.log(response)
    response.status_code === 200
      ? console.log("Se envio el mensaje sin errores")
      : console.log("Ocurrio un error al enviar el mensaje");
  });
}

function ReceiveMessage(id = null, callback = callback_default) {
  // nuevo mensaje recibido
  socket.on("newMessage", message => {
    // let user = store.getState().authentication.user._id;
    socket.emit("updateMessageToRead", { messageId: message._id });

    if (id != null && message.conversationId == id) {
      // if (message.senderId._id != user)
      //   socket.emit("updateMessageToRead", { messageId: message._id });

      callback(message);
    }
  });
}

function listChatsRecents() {
  // evaluando los chats recientes
  socket.on("recents", response => {
    // console.log(response._id);

    // console.log("MENSAJE NUEVO RECENT", response);
    // console.log(!response.hasOwnProperty('newScoring'));
    // console.log(response.conversationType != "group");

    // TODOLUIS linea para actualizar listado de mensajes
    if (response.conversationType != "group" && !response.hasOwnProperty('newScoring') && !response.hasOwnProperty('delete')) {
      console.log("MENSAJE QUE SE GUARDA (comentado)");
      // console.log(response);
      store.dispatch(listConversationsActions.updateConversations(response));
    }
    else if (response.conversationType === "group") {
      store.dispatch(listConversationsActions.notifyGroup(true));
    } else if (response.hasOwnProperty('newScoring')) {
      console.log("se recibio una notificacion");
      store.dispatch(userActions.newNotification(true));
    } else if (response.hasOwnProperty('delete')) {
      store.dispatch(listConversationsActions.deleteConversation(response.conversationId));
      store.dispatch(listConversationsActions.conversationDeleted(response.conversationId));
    }

    // callback(response);
    // socket.emit(
    //   "updateMessageToReceived",
    //   { messageId: response._id },
    //   response => {
    //     console.log(response);
    //   }
    // );
  });
}

function sendNotification(userId) {
  console.log("userId", userId)
  socket.emit("scoringNotification", userId);
}

function reconnect(conversationId, callback) {
  socket.on('reconnect', () => {
    if (store.getState().listConversations.conversationActive != "") {
      socket.emit("join", { conversationId: store.getState().listConversations.conversationActive }, function (response) {
        if (response.status_code === 200) {
          callback();
          console.log(`conexión exitosa al canal ${store.getState().listConversations.conversationActive}`);
        } else {
          console.log("Ocurrio un error");
        }
      });
    } else if (callback) {
      callback();
    }
  });
}

function deleteConversation(conversationId, users) {
  socket.emit('deleteConversation', { conversationId, users });
}


function socketDisconnect(callback) {
  socket.on('disconnect', () => {
    store.dispatch(userActions.connectionStatus(false));
    console.log("estado de la conexion", store.getState().authentication.connectionStatus);
    callback();
  })
}

function socketPing(callback) {
  socket.on('ping', () => {
    callback(true);
  })
}

function callback_default(response) {
  console.log("Evento ocurrido al enviar un mensaje: (comentado) \n");
  // console.log(response);
}

function socketDisconnectServer(callback) {
  socket.disconnect();
}

export default SocketUtils = {
  ConnectedServer,
  JoinChat,
  CloseChat,
  SendMessage,
  ReceiveMessage,
  listChatsRecents,
  sendNotification,
  reconnect,
  socketDisconnect,
  socketPing,
  deleteConversation,
  socketDisconnectServer
};
