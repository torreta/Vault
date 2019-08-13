/*
 * This file is test data, so i can centralize data for testing behavior inside the app. (API route)
 * URLs Application unique id. This id is saved on the server.
 */

import _ from "lodash";
import Moment from "moment";
// import locale from "./locale.js";

// Moment.updateLocale("es", locale);

function _generateRandomImageUrl() {
  var url = "https://placeimg.com/";
  var variation = Math.floor(Math.random() * (300 - 50) + 40);

  //para que al traerme imagenes de url distintas se vea obligado a variar / repetir el request
  // por una imagen nueva y asi no repetir
  url = url + `/${variation}/${variation}/any`;

  return url;
}

var nombreGrupos = ["Inefables", "Conspiradores", "Impredecibles", "Artífices"];

var groupTitle = _.sample(nombreGrupos);

var rating = _.round(Math.random() * (5 - 0) + 0, 2); // 0 - 5 intervalo, 2 digitos redondeados

var ratingQuantity = Math.floor(Math.random() * (500 - 50) + 50);

var group_ranking = Math.floor(Math.random() * (500 - 50) + 50);

var global_ranking = Math.floor(Math.random() * (1500 - 50) + 500);

var textoDisplay =
  "Super largo texto, para mantener el maquetado al dia repetido, Super largo texto, para mantener el maquetado al dia repetido, Super largo texto, para mantener el maquetado al dia repetido, Super largo texto, para mantener ";

var channelbio =
  "Super largo texto, para mantener el maquetado de los canales  largo texto, generado con propositoto de maqueta para mantener el maquetado al dia repetido, Super largo texto, para mantener el maquetado al dia repetido, Super largo texto, para mantener ";

function _generateBoolean() {
  return _.sample([true, false]);
}

function _generateRating() {
  return _.round(Math.random() * (5 - 0) + 0, 2);
}

function _generateGroupRanking() {
  return Math.floor(Math.random() * (500 - 50) + 50);
}

function _generateGlobalRanking() {
  return Math.floor(Math.random() * (1500 - 50) + 500);
}

function _generateRatingCount() {
  return Math.floor(Math.random() * (500 - 50) + 50);
}

function _generateMembersCount() {
  return Math.floor(Math.random() * (1000 - 50) + 50);
}

function _generateGalleryCount() {
  return Math.floor(Math.random() * (1000 - 50) + 50);
}

function _generateGroup() {
  return _.sample(nombreGrupos);
}

function _generateMessageCount() {
  return Math.floor(Math.random() * 150 + 1);
}

function _generateCity() {
  var ciudades = [
    "Caracas",
    "Madrid",
    "Barcelona",
    "Zaragoza",
    "Maracay",
    "Ciudad de Parra",
    "Mordor D.C",
    "Boston",
    "Arkam",
    "Polo Polar Sur",
    "Luna",
    "Teractor",
    "Tokio",
    "SanFranSokio",
    "Babilonia",
    "Pelicanto",
    "Trujillo",
    "Bunker Subterraneo 64"
  ];
  return _.sample(ciudades);
}

function _generateUnreadMessageCount() {
  return Math.floor(Math.random() * 100 + 1);
}

function _generateDatePast() {
  var hours = Math.floor(Math.random() * 24 + 1);
  var minutes = Math.floor(Math.random() * 59 + 1);
  var tiempo = Moment()
    .subtract(hours, "hours")
    .subtract(minutes, "minutes");
  return tiempo;
}

function _generateDatePastSimple() {
  var horas = "1m_5m_15m_20m_30m_45m_1h_2h_5h_8h_12h_18h_1d_2d_3d_1w_2w_3w_1M_3M_6M_9M_1A".split(
    "_"
  );
  var tiempo = _.sample(horas);

  return tiempo;
}

function _generateTextId() {
  return Math.floor(Math.random() * 10000 + 10000);
}

function _generateImageId() {
  return Math.floor(Math.random() * 10000 + 20000);
}

function _generateVideoId() {
  return Math.floor(Math.random() * 10000 + 30000);
}

var interests = [
  {
    id: 1,
    title: "Tecnología y electrónica",
    selected: _.sample([true, false])
  },
  {
    id: 2,
    title: "Familia",
    selected: _.sample([true, false])
  },
  {
    id: 3,
    title: "Salud y bienestar",
    selected: _.sample([true, false])
  },
  {
    id: 4,
    title: "Movimientos",
    selected: _.sample([true, false])
  },
  {
    id: 5,
    title: "Educación",
    selected: _.sample([true, false])
  },
  {
    id: 6,
    title: "Moda y belleza",
    selected: _.sample([true, false])
  },
  {
    id: 7,
    title: "Comida y bebida",
    selected: _.sample([true, false])
  },
  {
    id: 8,
    title: "Creencias",
    selected: _.sample([true, false])
  },
  {
    id: 9,
    title: "Hecho a mano",
    selected: _.sample([true, false])
  },
  {
    id: 10,
    title: "Idiomas y cultura",
    selected: _.sample([true, false])
  },
  {
    id: 11,
    title: "LGBTI",
    selected: _.sample([true, false])
  },
  {
    id: 12,
    title: "Memes",
    selected: _.sample([true, false])
  },
  {
    id: 13,
    title: "Fotografía",
    selected: _.sample([true, false])
  },
  {
    id: 14,
    title: "Cine y ciencia ficción",
    selected: _.sample([true, false])
  },
  {
    id: 15,
    title: "Arte",
    selected: _.sample([true, false])
  },
  {
    id: 16,
    title: "Gaming",
    selected: _.sample([true, false])
  },
  {
    id: 17,
    title: "Viajes y aventura",
    selected: _.sample([true, false])
  },
  {
    id: 18,
    title: "Animales",
    selected: _.sample([true, false])
  },
  {
    id: 19,
    title: "Random",
    selected: _.sample([true, false])
  },
  {
    id: 20,
    title: "Noticias",
    selected: _.sample([true, false])
  },
  {
    id: 21,
    title: "Deportes y fitness",
    selected: _.sample([true, false])
  },
  {
    id: 22,
    title: "Hobbies",
    selected: _.sample([true, false])
  },
  {
    id: 23,
    title: "Social y relaciones",
    selected: _.sample([true, false])
  },
  {
    id: 24,
    title: "Música",
    selected: _.sample([true, false])
  },
  {
    id: 25,
    title: "Segunda mano",
    selected: _.sample([true, false])
  },
  {
    id: 26,
    title: "Imagenes y GIFs",
    selected: _.sample([true, false])
  },
  {
    id: 27,
    title: "Negocios y finanzas",
    selected: _.sample([true, false])
  },
  {
    id: 28,
    title: "Libros",
    selected: _.sample([true, false])
  }
];

var categories = [
  {
    key: 1,
    label: "Tecnología y electrónica",
    value: "Tecnología y electrónica"
  },
  {
    key: 2,
    label: "Familia",
    value: "Familia"
  },
  {
    key: 3,
    label: "Salud y bienestar",
    value: "Salud y bienestar"
  },
  {
    key: 4,
    label: "Movimientos",
    value: "Movimientos"
  },
  {
    key: 5,
    label: "Educación",
    value: "Educación"
  },
  {
    key: 6,
    label: "Moda y belleza",
    value: "Moda y belleza"
  },
  {
    key: 7,
    label: "Comida y bebida",
    value: "Comida y bebida"
  },
  {
    key: 8,
    label: "Creencias",
    value: "Creencias"
  },
  {
    key: 9,
    label: "Hecho a mano",
    value: "Hecho a mano"
  },
  {
    key: 10,
    label: "Idiomas y cultura",
    value: "Idiomas y cultura"
  },
  {
    key: 11,
    label: "LGBTI",
    value: "LGBTI"
  },
  {
    key: 12,
    label: "Memes",
    value: "Memes"
  },
  {
    key: 13,
    label: "Fotografía",
    value: "Fotografía"
  },
  {
    key: 14,
    label: "Cine y ciencia ficción",
    value: "Cine y ciencia ficción"
  },
  {
    key: 15,
    label: "Arte",
    value: "Arte"
  },
  {
    key: 16,
    label: "Gaming",
    value: "Gaming"
  },
  {
    key: 17,
    label: "Viajes y aventura",
    value: "Viajes y aventura"
  },
  {
    key: 18,
    label: "Animales",
    value: "Animales"
  },
  {
    key: 19,
    label: "Random",
    value: "Random"
  },
  {
    key: 20,
    label: "Noticias",
    value: "Noticias"
  },
  {
    key: 21,
    label: "Deportes y fitness",
    value: "Deportes y fitness"
  },
  {
    key: 22,
    label: "Hobbies",
    value: "Hobbies"
  },
  {
    key: 23,
    label: "Social y relaciones",
    value: "Social y relaciones"
  },
  {
    key: 24,
    label: "Música",
    value: "Música"
  },
  {
    key: 25,
    label: "Segunda mano",
    value: "Segunda mano"
  },
  {
    key: 26,
    label: "Imagenes y GIFs",
    value: "Imagenes y GIFs"
  },
  {
    key: 27,
    label: "Negocios y finanzas",
    value: "Negocios y finanzas"
  },
  {
    key: 28,
    label: "Libros",
    value: "Libros"
  }
];

var interestRandomQuantity = Math.floor(Math.random() * _.size(interests) + 1); //1-28
var ointerestRandomQuantity = Math.floor(Math.random() * _.size(interests) + 1); //1-28

var randomInterests = _.sampleSize(interests, interestRandomQuantity);
var othersRandomInterests = _.sampleSize(interests, ointerestRandomQuantity);

function _generateInterestText() {
  var este = "";
  var i = 0;

  _.forEach(randomInterests, function(interest) {
    if (i == 0) {
      este = interest.title;
      i = i + 1;
    } else {
      este = este + ", " + interest.title;
    }
  });

  return este;
}

function _generateoInterestText() {
  var este = "";
  var i = 0;

  _.forEach(randomInterests, function(interest) {
    if (i == 0) {
      este = interest.title;
      i = i + 1;
    } else {
      este = este + ", " + interest.title;
    }
  });

  return este;
}

var randomInterestsText = _generateInterestText();

var othersRandomInterestsText = _generateoInterestText();

var otherUsers = [
  {
    id: 1,
    _id: 1,
    username: "Pablito01",
    name: "Pablito Escobarcito",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "05/02/1988",
    member_since: "06/05/2018",
    city: _generateCity(),
    sex: "Hombre",
    bio: "Pablito01" + textoDisplay
  },
  {
    id: 2,
    _id: 2,
    username: "Antont",
    name: "Antonio Tirant",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "02/01/1945",
    member_since: "08/08/2006",
    city: _generateCity(),
    sex: "Hombre",
    bio: "Antont" + textoDisplay
  },
  {
    id: 3,
    _id: 3,
    username: "Mariela",
    name: "Mariela Camacho",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "06/06/1991",
    member_since: "09/12/2017",
    city: _generateCity(),
    sex: "Mujer",
    bio: "Mariela" + textoDisplay
  },
  {
    id: 4,
    _id: 4,
    username: "AlejandraLA",
    name: "Alejandra La´dana",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "01/01/2000",
    member_since: "12/12/2016",
    city: _generateCity(),
    sex: "Mujer",
    bio: "AlejandraLA" + textoDisplay
  },
  {
    id: 5,
    _id: 5,
    username: "Mireia33",
    name: "Mireia D´torres",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "04/03/2001",
    member_since: "06/05/2012",
    city: _generateCity(),
    sex: "Mujer",
    bio: "Mireia33" + textoDisplay
  },
  {
    id: 6,
    _id: 6,
    username: "Jose21",
    name: "Jose Polento",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "13/03/1993",
    member_since: "01/02/2019",
    city: _generateCity(),
    sex: "Hombre",
    bio: "Jose21" + textoDisplay
  },
  {
    id: 7,
    _id: 7,
    username: "Francisca.3",
    name: "Francisca Corvo",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "12/11/1964",
    member_since: "08/07/2017",
    city: _generateCity(),
    sex: "Mujer",
    bio: "Francisca.3" + textoDisplay
  },
  {
    id: 8,
    _id: 8,
    username: "Helena00",
    name: "Helena Bond",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "02/08/1977",
    member_since: "01/06/2017",
    city: _generateCity(),
    sex: "Mujer",
    bio: "Helena00" + textoDisplay
  },
  {
    id: 9,
    _id: 9,
    username: "PaulaSH",
    name: "Paula Shapiro Hortiz",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "05/05/1985",
    member_since: "03/06/2019",
    city: _generateCity(),
    sex: "Mujer",
    bio: "PaulaSH" + textoDisplay
  },
  {
    id: 10,
    _id: 10,
    username: "Hectorr3",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "22/12/2010",
    member_since: "08/12/2016",
    city: _generateCity(),
    sex: "Hombre",
    bio: "Hectorr3" + textoDisplay
  },
  {
    id: 11,
    _id: 11,
    username: "Pablo03",
    name: "Pablo Barranca",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "04/05/2000",
    member_since: "06/01/2019",
    city: _generateCity(),
    sex: "Hombre",
    bio: "Pablo03" + textoDisplay
  },
  {
    id: 12,
    _id: 12,
    username: "Julia PA",
    name: "Julia Paris Almodobar",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "31/01/1996",
    member_since: "05/03/2019",
    city: _generateCity(),
    sex: "Mujer",
    bio: "Julia PA" + textoDisplay
  },
  {
    id: 13,
    _id: 13,
    username: "Marina34",
    name: "Marina Canelon",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "12/11/1934",
    member_since: "01/03/1997",
    city: _generateCity(),
    sex: "Mujer",
    bio: "Marina34" + textoDisplay
  },
  {
    id: 14,
    _id: 14,
    username: "Pepe213",
    name: "Pedro Eduardo Padilla Erasmo",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "05/02/1993",
    member_since: "06/05/2006",
    city: _generateCity(),
    sex: "Hombre",
    bio: "Pepe213" + textoDisplay
  },
  {
    id: 15,
    _id: 15,
    username: "Mauricio99",
    name: "Mauricio Zapata",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "05/02/1994",
    member_since: "06/05/2005",
    city: _generateCity(),
    sex: "Hombre",
    bio: "Mauricio99" + textoDisplay
  },
  {
    id: 16,
    _id: 16,
    username: "Paco007",
    name: "Pierre A Cordoba O",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "05/02/1995",
    member_since: "06/05/2006",
    city: _generateCity(),
    sex: "Hombre",
    bio: "Paco007" + textoDisplay
  },
  {
    id: 17,
    _id: 17,
    username: "Ester64",
    name: "Ester Zulillo",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "05/02/1997",
    member_since: "06/05/2007",
    city: _generateCity(),
    sex: "Mujer",
    bio: "Ester64" + textoDisplay
  },
  {
    id: 18,
    _id: 18,
    username: "Manuel45",
    name: "Manuel Marruero",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "05/02/1998",
    member_since: "06/05/2008",
    city: _generateCity(),
    sex: "Hombre",
    bio: "Manuel45" + textoDisplay
  },
  {
    id: 19,
    _id: 19,
    username: "Laiia12",
    name: "Laila Torres",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "05/02/1999",
    member_since: "06/05/2009",
    city: _generateCity(),
    sex: "Mujer",
    bio: "Laiia12" + textoDisplay
  },
  {
    id: 20,
    _id: 20,
    username: "LauraGarcia",
    name: "Laura Garcia",
    rating: _generateRating(),
    rating_quantity: _generateRatingCount(),
    group: _generateGroup(),
    avatar: _generateRandomImageUrl(),
    group_ranking: _generateGroupRanking(),
    global_ranking: _generateGlobalRanking(),
    birth: "05/02/1985",
    member_since: "06/05/2018",
    city: _generateCity(),
    sex: "Mujer",
    bio: "LauraGarcia" + textoDisplay
  }
];

function _generateOtherUser() {
  var otherUsersLocal = otherUsers;
  return _.sample(otherUsersLocal);
}

var blockedUsersQuantity = Math.floor(
  (Math.random() * _.size(otherUsers)) / 4 + 1
);

var blockedUsers = _.sampleSize(otherUsers, blockedUsersQuantity);

var video_messages = [
  {
    _id: _generateVideoId(),
    text: "video 1 miedo",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image:
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  },
  {
    _id: _generateVideoId(),
    text: "video 2 respiracion",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image:
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  },
  {
    _id: _generateVideoId(),
    text: "video 3 alimentacion",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image:
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  },
  {
    _id: _generateVideoId(),
    text: "video 4 propiedad privada",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image:
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  },
  {
    _id: _generateVideoId(),
    text: "video 5 familia",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image:
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  },
  {
    _id: _generateVideoId(),
    text: "video 6 amistad",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image:
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  },
  {
    _id: _generateVideoId(),
    text: "video 7 afecto",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image:
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  },
  {
    _id: _generateVideoId(),
    text: "video 8 confianza",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image:
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  },
  {
    _id: _generateVideoId(),
    text: "video 9 respeto",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image:
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  },
  {
    _id: _generateVideoId(),
    text: "video 10 resolucion",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image:
      "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
  }
];

var image_messages = [
  {
    _id: _generateImageId(),
    text: "imagen 1 descanso",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image: "https://facebook.github.io/react/img/logo_og.png"
  },
  {
    _id: _generateImageId(),
    text: "imagen 2 homeostasis",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image: "https://facebook.github.io/react/img/logo_og.png"
  },
  {
    _id: _generateImageId(),
    text: "imagen 3 seguridad fisica",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image: "https://facebook.github.io/react/img/logo_og.png"
  },
  {
    _id: _generateImageId(),
    text: "imagen 4 seguridad empleo",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image: "https://facebook.github.io/react/img/logo_og.png"
  },
  {
    _id: _generateImageId(),
    text: "imagen 5 intimidad",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image: "https://facebook.github.io/react/img/logo_og.png"
  },
  {
    _id: _generateImageId(),
    text: "imagen 6 sexyness",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image: "https://facebook.github.io/react/img/logo_og.png"
  },
  {
    _id: _generateImageId(),
    text: "imagen 7 respeto",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image: "https://facebook.github.io/react/img/logo_og.png"
  },
  {
    _id: _generateImageId(),
    text: "imagen 8 autorreconocimiento",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image: "https://facebook.github.io/react/img/logo_og.png"
  },
  {
    _id: _generateImageId(),
    text: "imagen 9 expontaneidad",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image: "https://facebook.github.io/react/img/logo_og.png"
  },
  {
    _id: _generateImageId(),
    text: "imagen 10 falta prejuicios",
    createdAt: Moment(),
    user: _generateOtherUser(),
    image: "https://facebook.github.io/react/img/logo_og.png"
  }
];

var text_messages = [
  {
    _id: _generateTextId(),
    text: "texto 1",
    createdAt: Moment(),
    user: _generateOtherUser()
  },
  {
    _id: _generateTextId(),
    text: "texto 2",
    createdAt: Moment(),
    user: _generateOtherUser()
  },
  {
    _id: _generateTextId(),
    text: "texto 3",
    createdAt: Moment(),
    user: _generateOtherUser()
  },
  {
    _id: _generateTextId(),
    text: "texto 4",
    createdAt: Moment(),
    user: _generateOtherUser()
  },
  {
    _id: _generateTextId(),
    text: "texto 5",
    createdAt: Moment(),
    user: _generateOtherUser()
  },
  {
    _id: _generateTextId(),
    text: "texto 6",
    createdAt: Moment(),
    user: _generateOtherUser()
  },
  {
    _id: _generateTextId(),
    text: "texto 7",
    createdAt: Moment(),
    user: _generateOtherUser()
  },
  {
    _id: _generateTextId(),
    text: "texto 8",
    createdAt: Moment(),
    user: _generateOtherUser()
  },
  {
    _id: _generateTextId(),
    text: "texto 9",
    createdAt: Moment(),
    user: _generateOtherUser()
  },
  {
    _id: _generateTextId(),
    text: "texto 10",
    createdAt: Moment(),
    user: _generateOtherUser()
  }
];

var random_video_messages_quantity = Math.floor(
  (Math.random() * _.size(video_messages)) / 3 + 1
);

var random_video_messages = _.sampleSize(
  video_messages,
  random_video_messages_quantity
);

var random_image_messages_quantity = Math.floor(
  (Math.random() * _.size(image_messages)) / 3 + 1
);

var random_image_messages = _.sampleSize(
  image_messages,
  random_image_messages_quantity
);

var random_text_messages_quantity = Math.floor(
  (Math.random() * _.size(text_messages)) / 3 + 1
);

var random_text_messages = _.sampleSize(
  text_messages,
  random_text_messages_quantity
);

var random_messages = _.shuffle(
  _.flattenDeep([
    random_text_messages,
    random_video_messages,
    random_image_messages
  ])
);

var random_messages_group = _.shuffle(
  _.flattenDeep([
    random_text_messages,
    random_video_messages,
    random_image_messages
  ])
);

var random_messages_single = _.shuffle(
  _.flattenDeep([
    random_text_messages,
    random_video_messages,
    random_image_messages
  ])
);

var messages = _.flatten([text_messages, video_messages, image_messages]);

function _generateMessage() {
  var messagesLocal = messages;
  return _.sample(messagesLocal);
}

function _othersRankingGlobal() {
  var otherUsersLocal = otherUsers;
  var otherUsersShuffleGlobal = _.shuffle(otherUsersLocal);
  var afterAddingPositionUsersGlobal = [];
  var i = 1;

  _.forEach(otherUsersShuffleGlobal, function(user) {
    user.global_ranking = i;
    user.group = _generateGroup();
    i = i + 1;
    afterAddingPositionUsersGlobal.push(user);
  });

  return afterAddingPositionUsersGlobal;
}

function _othersRanking() {
  var otherUsersLocal = otherUsers;
  var usuarioActual = user;
  var otherUsersShuffle = _.shuffle(otherUsersLocal);
  var afterAddingPositionUsers = [];
  var i = 1;

  _.forEach(otherUsersShuffle, function(user) {
    user.group_ranking = i;
    user.group = usuarioActual.group;
    i = i + 1;
    afterAddingPositionUsers.push(user);
  });

  return afterAddingPositionUsers;
}

function _GroupRankings() {
  var nombreGrupos = [
    "Inefables",
    "Conspiradores",
    "Impredecibles",
    "Artífices"
  ];
  var bio = textoDisplay;
  var shuffleNombreGrupos = _.shuffle(nombreGrupos);
  var afterAddingRatingGroups = [];
  var afterAddingPositionGroups = [];
  var i = 1;
  var grupo_objeto = {};

  // creating group object
  _.forEach(shuffleNombreGrupos, function(group_name) {
    grupo_objeto.name = group_name;
    grupo_objeto.rating = _generateRating();
    grupo_objeto.members = _generateMembersCount();
    grupo_objeto.media_count = _generateGalleryCount();
    afterAddingRatingGroups.push(grupo_objeto);
    grupo_objeto.bio = group_name + "  " + bio;
    grupo_objeto = {};
  });

  //sorting by rating
  afterAddingRatingGroups = _.sortBy(afterAddingRatingGroups, ["rating"]);
  afterAddingRatingGroups = _.reverse(afterAddingRatingGroups);

  //addding rank after sorting
  _.forEach(afterAddingRatingGroups, function(group) {
    group.rank = i;
    i = i + 1;
    afterAddingPositionGroups.push(group);
  });

  return afterAddingPositionGroups;
}

var channels = [
  {
    id: 1,
    name: "Drones",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Drones" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 2,
    name: "Perros",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Perros" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 3,
    name: "Remedios Caseros",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Remedios Caseros" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 4,
    name: "Ejercicios En Exteriores",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Ejercicios En Exteriores" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 5,
    name: "Cursos Gratis",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Cursos Gratis" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 6,
    name: "Trucos de belleza",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Trucos de belleza" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 7,
    name: "Comida Continental",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Comida Continental" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 8,
    name: "Historias Religiosas",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Historias Religiosas" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 9,
    name: "Manualidades Reciclables",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Manualidades Reciclables" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 10,
    name: "Español y Groserias",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Español y Groserias" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 11,
    name: "Grupos de Draqueens",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Grupos de Draqueens" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 12,
    name: "Comiguitas",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Comiguitas" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 13,
    name: "Paisajes Hermosos",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Paisajes Hermosos" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 14,
    name: "Discusiones de Series",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Discusiones de Series" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 15,
    name: "Galerias Especiales",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Galerias Especiales" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 16,
    name: "Juegos en Hype",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Juegos en Hype" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 17,
    name: "Mejores Sitios Vacionales",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Mejores Sitios Vacionales" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 18,
    name: "Mejores Animales para Criar",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Mejores Animales para Criar" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 19,
    name: "Cosas Divertidas",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Cosas Divertidas" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 20,
    name: "Ultimos Encabezados Importantes",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Ultimos Encabezados Importantes" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 21,
    name: "Eventos Deportivos",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Eventos Deportivos" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 22,
    name: "Cosas que Hacer",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Cosas que Hacer" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 23,
    name: "Redes Sociales",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Redes Sociales" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 24,
    name: "Conciertos",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Conciertos" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 25,
    name: "Reventa",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Reventa" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 26,
    name: "Intercambios Digitales",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Intercambios Digitales" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 27,
    name: "Emprendedores",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Emprendedores" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  },
  {
    id: 28,
    name: "Libros de Segunda Mano",
    tag: _.sample(interests).title,
    avatar: _generateRandomImageUrl(),
    type: _.sample(["single", "group"]),
    last_message: _generateMessage(),
    message_count: _generateMessageCount(),
    user: _generateOtherUser(),
    description: "Libros de Segunda Mano" + channelbio,
    members: _generateMembersCount(),
    media_count: _generateGalleryCount()
  }
];

var channelsRandomQuantity = Math.floor(Math.random() * _.size(channels) + 1); //1-28

var othersChannelsRandomQuantity = Math.floor(
  Math.random() * _.size(channels) + 1
);

var randomChannels = _.sampleSize(channels, channelsRandomQuantity);
var othersRandomChannels = _.sampleSize(channels, othersChannelsRandomQuantity);
var popularChannels = _.sampleSize(channels, 4);
var BasedOnChannels = _.sampleSize(channels, 4);
var popularChannelsAll = _.sampleSize(channels, channelsRandomQuantity);
var BasedOnChannelsAll = _.sampleSize(channels, channelsRandomQuantity);

var user = _.sample([
  {
    id: 1,
    name: "pedro roberto aponte",
    group: groupTitle,
    username: "padroJJa",
    birth: "25/01/2002",
    rating: rating,
    rating_quantity: ratingQuantity,
    group_ranking: group_ranking,
    global_ranking: global_ranking,
    member_since: "04/11/2009",
    city: "Barcelona",
    sex: "Hombre",
    bio: textoDisplay,
    avatar: _generateRandomImageUrl()
  },
  {
    id: 2,
    name: "merida victoria pacheco",
    group: groupTitle,
    username: "MManda",
    birth: "05/02/1992",
    rating: rating,
    rating_quantity: ratingQuantity,
    group_ranking: group_ranking,
    global_ranking: global_ranking,
    member_since: "06/05/2005",
    city: "Madrid",
    sex: "Mujer",
    bio: textoDisplay,
    avatar: _generateRandomImageUrl()
  }
]);

function _notifications() {
  var otherUsersLocal = otherUsers;
  var otherUsersShuffleGlobal = _.shuffle(otherUsersLocal);
  var notificationsArray = [];
  var i = 1;

  _.forEach(otherUsersShuffleGlobal, function(user) {
    user.global_ranking = i;
    user.group = _generateGroup();
    user.created_at = _generateDatePastSimple();

    i = i + 1;
    notificationsArray.push(user);
  });

  return notificationsArray;
}

function _valorations() {
  var otherUsersLocal = otherUsers;
  var otherUsersShuffleGlobal = _.shuffle(otherUsersLocal);
  var notificationsArray = [];
  var i = 1;

  _.forEach(otherUsersShuffleGlobal, function(user) {
    user.global_ranking = i;
    user.group = _generateGroup();
    user.created_at = _generateDatePastSimple();

    i = i + 1;
    notificationsArray.push(user);
  });

  return notificationsArray;
}

export default (DinamicTestData = {
  randomInterests: randomInterests,
  randomInterestsText: randomInterestsText,
  othersRandomInterests: othersRandomInterests,
  othersRandomInterestsText: othersRandomInterestsText,
  interests: interests,
  categories: categories,
  interestRandomQuantity: interestRandomQuantity,
  groupTitle: groupTitle,
  rating: rating,
  ratingQuantity: ratingQuantity,
  bolea: _generateBoolean(),
  user: user,
  randomChannels: randomChannels,
  othersRandomChannels: othersRandomChannels,
  popularChannels: popularChannels,
  popularChannelsAll: popularChannelsAll,
  BasedOnChannels: BasedOnChannels,
  BasedOnChannelsAll: BasedOnChannelsAll,
  otherUsers: otherUsers,
  otherUser: _generateOtherUser(),
  blockedUsers: blockedUsers,
  otherUsersRanking: _othersRanking(),
  otherUsersRankingGlobal: _othersRankingGlobal(),
  notifications: _notifications(),
  valorations: _valorations(),
  groupRankings: _GroupRankings(),
  hora: _generateDatePast(),
  messages: messages,
  random_messages: random_messages,
  random_messages_group: random_messages_group,
  random_messages_single: random_messages_single,
  messageCount: _generateMessageCount(),
  unreadMessageCount: _generateUnreadMessageCount(),
  message_random: _generateMessage(),
  message: _generateMessage()
});
