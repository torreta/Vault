import * as React from "react";
import {
  View,
  Dimensions,
  TouchableOpacity,
  StyleSheet
} from "react-native";
import { BackHandler } from "react-native";
import ImageViewer from 'react-native-image-zoom-viewer';
import { Feather } from '@expo/vector-icons';

const { height } = Dimensions.get("window");
export default class ImageZoom extends React.Component {

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
    let image = this.props.navigation.state.params.url.uri != undefined ? 
      [{ url: this.props.navigation.state.params.url.uri }] :
      [{ props: { url: '', source: this.props.navigation.state.params.url } }]
    return (

      <View style={{ flex: 1, height: height }}>
        <View style={{ alignItems: 'flex-end' }}>
          <TouchableOpacity
            onPress={() => this.props.navigation.navigate(this.props.navigation.state.params.return_to)}
            style={styles.buttonZoom}
          >
            <Feather name="minimize" size={32} color="rgb(253, 92, 99)" />
          </TouchableOpacity>
        </View>
        <ImageViewer imageUrls={image} renderIndicator={() => null} />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  buttonZoom:{
    backgroundColor: '#eee',
    width: 36,
    height: 36,
    justifyContent: 'center',
    alignContent: 'center',
    borderRadius: 10,
    alignItems: 'center',
    margin: 10,
    marginTop: 30
    // position: "absolute"
  }
});