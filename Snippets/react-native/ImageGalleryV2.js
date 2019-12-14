import React from "react";
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
import store from "../redux/store";
import { connect } from "react-redux";
import { listConversationsActions } from "../redux/actions";

import watch from "redux-watch";

const { width } = Dimensions.get("window");
const photo_cell_width = width / 4 - 4;

let items = [];

class ImageGallery extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      // items: [],
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

    let w = watch(store.getState, "listConversations.conversationDeleted");
    this.unsubscribe = store.subscribe(
      w((newVal, oldVal, objectPath) => {
        if(newVal == store.getState().channelInfo.data.conversationId){
          this.props.updateConversationActive("");
          this.props.navigation.navigate("ChatsStack", {
            deleteChannel: true
          });
        }
      })
    );
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
          let itemsFormated = response.map((message, i) => {
            //Using demo placeholder images but you can add your images here
            return { ...message, id: message._id };
          });
          items = itemsFormated;
          this.setState({ loading: false, conversationExists: true })
        })
        .catch(error => {
          console.log("error al buscar imagenes", error);
        })
    } else {
      items = [];
      this.setState({ loading: false, conversationExists: false })
    }
  }

  _renderElements() {
    let response = items.map(item => {
      console.log("segundo mapeo", item)
      return <ImageElement key={item._id} id={item._id} data={item} navigation={this.props.navigation} />
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
                (items.length > 0 ?
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
    console.log("image", image)
    this.props.navigation.navigate("ImageDisplayer", {
      return_to: "ImageGallery",
      image,
      allImages: items
    });
  }

  render() {
    return (
      <TouchableOpacity
        style={styles.imageItemPress}
        onPress={() => this._onPhotoPress(this.props.data)}
      >
        <Image
          key={this.props.id}
          source={{ uri: this.props.data.image }}
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
    flex: 1,
    marginTop: 20,
    marginLeft: 4
  },
  imageContainer: {
    flex: 1,
    flexDirection: "row",
    justifyContent: "flex-start",
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

const mapPropsToDispatch = {
  updateConversationActive: listConversationsActions.updateConversationActive,
};

export default connect(null, mapPropsToDispatch)(ImageGallery)