import * as React from "react";
import {
  StyleSheet,
  View,
  Dimensions,
  ScrollView,
  TouchableOpacity,
  Image,
  ActivityIndicator,
  Text
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

    this.state = {
      items: [],
      loading: true,
      conversationExists: true
    };
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
    if (this.props.navigation.state.params.conversationId != 0) {
      ApiUtils.get(
        `${API.url}api/conversations/${this.props.navigation.state.params.conversationId}/media`
      )
        .then(response => {
          // console.log("imagenes del canal", response);
          let items = response.map((message, i) => {
            //Using demo placeholder images but you can add your images here
            return { id: message._id, src: message.image };
          });
          this.setState({ items, loading: false, conversationExists: true })
        })
        .catch(error => {
          console.log("error al buscar imagenes", error);
        })
    } else {
      this.setState({ items: [], loading: false, conversationExists: false })
    }
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
      <View style={styles.contentGalery}>
        <GenericHeader
          title="Galeria"
          navigation={this.props.navigation}
        />
        <ScrollView>
          <View
            style={styles.imageContainer}
          >
            {this.state.loading == true ?
              (<ActivityIndicator
                style={[styles.spinner, { height: 40 }]}
                color={"rgb(57,62,70)"}
                size="large"
              />) :
              (this.state.conversationExists == true ?
                (this.state.items.length > 0 ?
                  (this._renderElements()) :
                  (<Text> La conversacion no posee ninguna imagen todavia </Text>)) :
                (<Text> Usted no posee una conversacion con este usuario, para iniciarla debe hacerlo desde la pantalla anterior </Text>)
              )}
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
        style={styles.imageItemPress}
        onPress={() => this._onPhotoPress({ uri: this.props.src })}
      >
        <Image
          key={this.props.id}
          source={{ uri: this.props.src }}
          style={styles.imageItem}
          resizeMode="cover"
        />
      </TouchableOpacity>
    );
  }
}

const styles = StyleSheet.create({
  contentGalery: {
    justifyContent: 'center',
    flex: 1, marginTop: 20
  },
  imageContainer: {
    flex: 1,
    flexDirection: "row",
    justifyContent: "center",
    flexWrap: "wrap"
  },
  imageItemPress: {
    height: photo_cell_width,
    width: photo_cell_width,
    margin: 1
  },
  imageItem: {
    height: photo_cell_width,
    width: photo_cell_width
  },
  textMessage: {}
})