/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
//import type {Node} from 'react';
import  {Node} from 'react';
import {
  Button,
  Image,
  //SafeAreaView,
  //ScrollView,
  //StatusBar,
  StyleSheet,
  Text,
  TextInput,
  useColorScheme,
  View,
} from 'react-native';

import {
  Colors,
  //DebugInstructions,
  //Header,
  //LearnMoreLinks,
  //ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';
import { wrap } from 'yargs';
import { whileStatement } from '@babel/types';


/*const MyButton = ({text, color}): Node =>{
  return (
    <Button
      title={text}
      color={color}
      //onPress={() => Button.color = "blue"}
      >
      </Button>
  )
}*/

const SpecificButton = ({}): Node => {
  return <Button title="Button" color={buttonColor} />
}

const App: () => Node = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <View style = {{flex: 1, flexDirection: "column"}}>

      {/* Container for image */}
      <View style = {styles.imageContainer}>
        <Image
          style = {styles.image}
          source={require('./Education-Wheel-Woofer.png')}
        />
      </View>

      {/* Container for buttons */}
      <View style = {styles.buttonGrid}>
        <View style={styles.buttonRow}>
          <SpecificButton/>
          <SpecificButton/>
        </View>

        <View style={styles.buttonRow}>
          <SpecificButton/>
          <SpecificButton/>
        </View>
        
      </View>

      {/* Container for email input */}
      <View style = {styles.inputContainer}>
        <Text style={styles.text}>Email:</Text>

        {/* Container for input field, to specify width and alignment */}
        <View style={styles.inputFieldContainer}>
          <TextInput style={styles.inputField}></TextInput>
        </View>
      </View>
    </View>
  );
};

const buttonColor = "gray";

const styles = StyleSheet.create({
  imageContainer: {
    //backgroundColor: "pink",
    padding: 10,
    flex: 1,
  },
  buttonGrid: {
    //backgroundColor: "green",
    flex: 1,
    flexDirection: "column",
    justifyContent: "space-evenly",
  },
  buttonRow: {
    //backgroundColor: "blue",
    flexDirection: "row",
    justifyContent: "space-evenly",
  },
  inputContainer: {
    //backgroundColor: "purple",
    flexDirection: "row",
    flexWrap: "wrap",
    justifyContent:"space-around",
    flex: 2
  },
  icon: {
    height: "50",
    width: "50"
  },
  image: {
    flex: 1, //to get the correct size of the image
    width: null,
    heigh: null,
    resizeMode: 'contain', //resize to fit parent's size?
  },
  text: {
    //backgroundColor: "red",
    color: "black",
    alignSelf: 'flex-end',
  },
  inputField: {
    //backgroundColor: "yellow",
    borderBottomWidth: 1,
    width: "80%", //Width of the wrapping container (View)
    paddingBottom: 0,
    //alignSelf: "center",
  },
  //Wraps the input field and enables more customized width
  // while the starting point of the input field stays the same
  inputFieldContainer: {
    //backgroundColor: "indigo",
    width: "70%",

  },
});

export default App;
