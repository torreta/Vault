import React from 'react';
import {TouchableOpacity, Image, View, Text, StyleSheet} from 'react-native';

const SquareButtonWithImage = ({imageSource, buttonName, onPress}) => {
  return (
    <TouchableOpacity style={styles.buttonContainer} onPress={onPress}>
      <Image source={imageSource} style={styles.image} />
      <Text style={styles.buttonText}>{buttonName}</Text>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  buttonContainer: {
    width: 120,
    height: 120,
    borderRadius: 10,
    backgroundColor: '#e0e0e0',
    justifyContent: 'center',
    alignItems: 'center',
    margin: 10,
  },
  image: {
    width: 80,
    height: 80,
    resizeMode: 'contain',
  },
  buttonText: {
    marginTop: 5,
    fontSize: 12,
    color: '#000',
  },
});

export default SquareButtonWithImage;
