import * as React from "react";
import {
  View,
  Dimensions,
  ScrollView,
  TouchableOpacity,
  Image
} from "react-native";
import { BackHandler } from "react-native";
import { GenericHeader } from "../components/GenericHeader";

import { ApiUtils } from "../utils/apiUtils";
import API from "../utils/api";

const { width } = Dimensions.get("window");
const photo_cell_width = width / 3 - 6;

export default class ImageGallery extends React.Component {
  constructor(props) {
    super(props);

    this.state = { items: [] };
  }

  static navigationOptions = {
    header: null
  };

  componentWillMount() {
    BackHandler.addEventListener("hardwareBackPress", function () {
      return true;
    });
  }

  componentDidMount() {
    this._shareImages();
  }

  _shareImages() {
    ApiUtils.get(
      `${API.url}api/conversations/${this.props.navigation.state.params.conversationId}/media`
    )
      .then(response => {
        // console.log("imagenes del canal", response);
        let items = response.map((message, i) => {
          //Using demo placeholder images but you can add your images here
          return { id: message._id, src: message.image };
        });
        console.log(items);
        this.setState({ items })
      })
      .catch(error => {
        console.log("error al buscar imagenes", error);
      })
  }

  _renderElements() {
    let response = this.state.items.map(item => {
      console.log("segundo mapeo", item)
      return <ImageElement key={item.id} id={item.id} src={item.src} navigation={this.props.navigation} />
    });
    return response;
  }

  render() {
    //Photo Grid of images
    return (
      <View style={{ justifyContent: 'center', flex: 1, marginTop: 20 }}>
        <GenericHeader
          title="Galeria"
          navigation={this.props.navigation}
        />
        <ScrollView>
          <View
            style={{ flex: 1, flexDirection: "row", justifyContent: "center" }}
          >
            {this._renderElements()}
          </View>
        </ScrollView>
      </View>
    );
  }
}

export class ImageElement extends React.Component {

  _onPhotoPress(image) {
    console.log("clicky photo")
    this.props.navigation.navigate("ImageDisplayer", {
      return_to: "ImageGallery",
      imageuri: image
    });
  }

  render() {
    return (
      <TouchableOpacity
        style={{ height: photo_cell_width, width: photo_cell_width, margin: 1 }}
        onPress={() => this._onPhotoPress({ uri: this.props.src })}
      >
        <Image
          key={this.props.id}
          source={{ uri: this.props.src }}
          style={{ height: photo_cell_width, width: photo_cell_width }}
          resizeMode="cover"
        />

      </TouchableOpacity>
    );
  }
}