import React from "react";
import { View, Dimensions, Text, Image, TouchableOpacity, StyleSheet } from "react-native";
import { BackHandler } from "react-native";
import { MaterialIcons } from '@expo/vector-icons';
import Carousel from 'react-native-anchor-carousel';
import ImageDisplayerHeader from "../components/ImageDisplayerHeader";
// import ImageViewer from 'react-native-image-zoom-viewer';

const { height, width } = Dimensions.get("window");

export default class ImageDisplayer extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      allImages: this.props.navigation.state.params.allImages,
      // allImages: images,
      imageFocused: this.props.navigation.state.params.image,
      initialIndex: 0
    };
  }
  
  componentDidMount() {
    this.setState({initialIndex: this.state.allImages.indexOf(this.state.imageFocused)});
    // this._carousel.snapToItem(2);
  }

  componentWillMount() {
    BackHandler.addEventListener("hardwareBackPress", function () {
      return true;
    });
  }

  static navigationOptions = {
    header: null
  };

  _renderItem = ({item, index}) => {
    return (
        <TouchableOpacity
          style={styles.thumbnailBackgroundView}
          onPress={ () => { 
            console.log("clicked to index", index)
            this._carousel.scrollToIndex(index);
            this.setState({ imageFocused: this.state.allImages[index] });
          }}
        >
          <Image
            style={styles.currentImage}
            source={{ uri: item.image }} 
            resizeMode="contain"
          />
        </TouchableOpacity>
    );
  }

  render() {
    return (
      <View>
        <ImageDisplayerHeader
          data={this.state.imageFocused}
          navigation={this.props.navigation}
        />
        <View style={{height: height - 235, width: width }}>
          <View style={{ alignItems: 'flex-end' }}>
            <TouchableOpacity
              onPress={() => {
                this.props.navigation.navigate("ImageZoom", {
                  return_to: "ImageDisplayer",
                  url: { uri: this.state.imageFocused.image }
                })
              }}
              style={styles.buttonZoom}
            >
              <MaterialIcons name="zoom-out-map" size={32} color="rgb(253, 92, 99)" />
            </TouchableOpacity>
          </View>
          <Image
            style={{ flex: 1 }}
            source={{ uri: this.state.imageFocused.image }} 
            resizeMode="contain"
          />
        </View>
        <View style={styles.carouselBackgroundView}>
          <Carousel
            ref={(c) => { this._carousel = c; }}
            data={this.state.allImages}
            renderItem={this._renderItem.bind(this)}
            itemWidth={200}
            containerWidth={width} 
            separatorWidth={0}
            initialIndex={this.state.initialIndex}
          />
        </View>
      </View>
    );

  }

}

const styles = StyleSheet.create({
  titleText: {
    // color: 'white',
    justifyContent: 'center',
    width: '100%'
  },
  currentImage: {
    // boxShadow: 10,
    // borderRadius: 10,
    flex: 1
  },
  thumbnailBackgroundView: {
    // justifyContent: 'center',
    // alingItems: 'center',
    // backgroundColor: '#000',
    height: 150,
    width: '100%'
  },
  carouselBackgroundView: {
    height: 220,
    marginTop: 15,
    justifyContent: 'center',
  },
  buttonZoom:{
    backgroundColor: '#eee',
    width: 36,
    height: 36,
    justifyContent: 'center',
    alignContent: 'center',
    borderRadius: 10,
    alignItems: 'center',
    margin: 10,
    // position: "absolute"
  }
});