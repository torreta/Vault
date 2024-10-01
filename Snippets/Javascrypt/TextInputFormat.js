import React from 'react';
import {StyleSheet, TextInput, View} from 'react-native';
import {useTheme} from '../utils/constance';
import TextFormatted from './TextFormated';
import Icon2 from 'react-native-vector-icons/Ionicons';
import IconAnt from 'react-native-vector-icons/AntDesign';
import colors from '../utils/colors';

const TextInputFormat = ({
  label,
  labelcolor,
  arrowicon,
  isNotEditable,
  emailValidIcon,
  isEmailValid,
  eyeOnPress,
  isEyeView,
  onTouch,
  maxlength,
  isSecure,
  txtref,
  label2,
  multiline,
  keyboardType,
  value,
  onEndEditing,
  onFocus,
  onChangeText,
  placeholder,
  top,
  height,
  right,
  font,
  family,
  ...props
}) => {
  return (
    <View style={{marginHorizontal: 25, marginTop: top || 10}}>
      <View
        style={{
          flexDirection: 'row',
          alignItems: 'center',
          justifyContent: 'space-between',
        }}>
        {label && (
          <TextFormatted
            style={{
              fontSize: 13,
              fontWeight: '400',
              color: labelcolor || colors.black,
            }}>
            {label}
          </TextFormatted>
        )}
        {label2 && (
          <TextFormatted
            style={{
              fontSize: 10,
              fontWeight: '600',
              color: colors.black,
              opacity: 0.2,
            }}>
            {label2}
          </TextFormatted>
        )}
      </View>
      <View
        style={{
          height: height || 48,
          borderWidth:
            emailValidIcon && value.length > 5 && !isEmailValid ? 1 : 0.5,
          borderRadius: height / 2 || 24,
          borderColor:
            emailValidIcon && value.length > 5 && !isEmailValid
              ? colors.appColor
              : '#c9c8c5',
          marginTop: 4,
          backgroundColor: colors.white,
          paddingHorizontal: 15,
          flexDirection: 'row',
          alignItems: 'center',
        }}>
        <TextInput
          {...props}
          ref={txtref}
          maxLength={maxlength}
          placeholder={placeholder}
          multiline={multiline}
          placeholderTextColor={colors.placeholdercolor}
          value={value}
          onChangeText={onChangeText}
          onFocus={onFocus}
          onEndEditing={onEndEditing}
          keyboardType={keyboardType}
          secureTextEntry={isSecure ? true : false}
          editable={isNotEditable ? false : true}
          onTouchStart={onTouch}
          style={{
            textAlignVertical: 'center',
            fontSize: font || 14,
            // fontFamily: family || 'Poppins-Regular',
            color: 'black',
            flex: 1,
          }}
        />
        <TextFormatted
          style={{
            fontSize: 10,
            fontWeight: '700',
            color: colors.appColor,
            textDecorationLine: 'underline',
          }}>
          {right}
        </TextFormatted>
        {arrowicon && <IconAnt name="down" size={20} color="gray" />}
        {eyeOnPress && (
          <Icon2
            name={isEyeView ? 'eye-outline' : 'eye-off-outline'}
            size={20}
            color="gray"
            onPress={() => eyeOnPress()}
          />
        )}
        {emailValidIcon && value.length > 5 && (
          <IconAnt
            name={isEmailValid ? 'checkcircle' : 'closecircle'}
            size={20}
            color={colors.appColor}
          />
        )}
      </View>
    </View>
  );
};

export default TextInputFormat;

const styles = StyleSheet.create({});
