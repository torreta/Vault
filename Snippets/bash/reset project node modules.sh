
# reset node
  rm -rf node_modules;
  rm package-lock.json;
  rm yarn.lock
  rm -rf $TMPDIR/react-native-packager-cache-*;
  rm -rf $TMPDIR/metro-*;
  rm -rf $TMPDIR/react-*;
  rm -rf $TMPDIR/haste-*;
  watchman watch-del-all;
  yarn;
  yarn start;