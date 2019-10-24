import * as React from "react";
import {
  View,
  Dimensions,
} from "react-native";
import { BackHandler } from "react-native";
import { GenericHeader } from "../components/GenericHeader";
import ImageViewer from 'react-native-image-zoom-viewer';

const { height } = Dimensions.get("window");
export default class ImageDisplayer extends React.Component {

  constructor(props) {
    super(props);
    this.state = { ModalVisibleStatus: false };
  }

  componentWillMount() {
    BackHandler.addEventListener("hardwareBackPress", function () {
      return true;
    });
  }

  static navigationOptions = {
    header: null
  };

  render() {
    let images;

    if (this.props.navigation.state.params.imageuri.uri != undefined) {
      images = [{ url: this.props.navigation.state.params.imageuri.uri }]
    } else {
      images = [{ props: { url: '', source: this.props.navigation.state.params.imageuri } }]
    }

    return (
      <View style={{ flex: 1, height: height }}>
        <GenericHeader
          title="Imagen"
          navigation={this.props.navigation}
        />
        <ImageViewer imageUrls={images} />
      </View>
    );

  }

}
