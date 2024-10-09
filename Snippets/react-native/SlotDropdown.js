import {StyleSheet, View} from 'react-native';
import React from 'react';
import {Dropdown} from 'react-native-element-dropdown';
import Icon from 'react-native-vector-icons/Entypo';
import TextFormatted from './TextFormated';
import colors from '../utils/colors';

const SlotDropdown = ({value,ddref,search, onChange, fontSize, data, borderRadius, height, title, renderRightIcon, position, placeholder,topMargin}) => {
  
  return (
    <View >     
      <Dropdown
      ref={ddref}
        style={[styles.dropdown]}
        dropdownPosition={position || 'auto'}        
        placeholderStyle={styles.placeholderStyle}
        selectedTextStyle={styles.selectedTextStyle}
        inputSearchStyle={styles.inputSearchStyle}
        data={data}
        search={search}
        maxHeight={height || 200}
        labelField="label"
        valueField="value"
        placeholder={placeholder}
        value={value}
        searchPlaceholder='Search here...'   
        //   onChange={item => setWeightMajor(item.value)}
        onChange={onChange}
        renderRightIcon={() => renderRightIcon || <Icon name="chevron-thin-down" color={colors.appColor} size={14} />}
        // renderLeftIcon={() => <Image source={require('../../Assets/Icons/Gender.png')} style={{ height: 18, width: 18, resizeMode: 'contain' }} />}
      />
    </View>
  );
};

export default SlotDropdown;

const styles = StyleSheet.create({
  dropdown: {
    height: 22, 
    width:100,              
    textAlignVertical: 'center',
    marginHorizontal: 5,    
  },
  placeholderStyle: {fontSize: 16, color: colors.placeholdercolor},
  selectedTextStyle: {fontSize: 16,  color: colors.black},
  inputSearchStyle: {height: 40,fontSize: 16,},
});
