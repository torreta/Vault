Before running your app on iOS, make sure you have CocoaPods installed and initialize the project:

  cd ios
  pod install

Then you can run the project:

  yarn android
  yarn ios

Warning: your app includes 2 packages that require additional setup. See the following URLs for instructions.
Your app may not build/run until the additional setup for these packages has been completed.

- expo-facebook: https://github.com/expo/expo/tree/master/packages/expo-facebook (listo en android)
- expo-image-picker: https://github.com/expo/expo/tree/master/packages/expo-image-picker (listo en android)

error React Native CLI uses autolinking for native dependencies, but the following modules are linked manually:
  - react-native-gesture-handler (to unlink run: "react-native unlink react-native-gesture-handler")
  - react-native-reanimated (to unlink run: "react-native unlink react-native-reanimated")
  - react-native-screens (to unlink run: "react-native unlink react-native-screens")