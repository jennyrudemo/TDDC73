/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow strict-local
 */

import React from 'react';
import type {Node} from 'react';
import {
  Button,
  Image,
  SafeAreaView,
  ScrollView,
  StatusBar,
  StyleSheet,
  Text,
  useColorScheme,
  View,
} from 'react-native';

import {
  Colors,
  DebugInstructions,
  Header,
  LearnMoreLinks,
  ReloadInstructions,
} from 'react-native/Libraries/NewAppScreen';
import { wrap } from 'yargs';


const MyButton = ({text, color}): Node =>{
  return (
    <Button
      title={text}
      color={color}
      //onPress={() => Button.color = "blue"}
      >
      </Button>
  )
}

const App: () => Node = () => {
  const isDarkMode = useColorScheme() === 'dark';

  const backgroundStyle = {
    backgroundColor: isDarkMode ? Colors.darker : Colors.lighter,
  };

  return (
    <View style = {{flex: 1, flexDirection: "column"}}>
      <View style = {styles.imageContainer}>
        <Image
          style = {styles.image}
          source={require('./Education-Wheel-Woofer.png')}
        />
      </View>

      <View style = {styles.buttonGrid}>
        <View style={[{backgroundColor: "red"}, styles.buttonRow]}>
          <Button title="Button" color={buttonColor} />
          <Button title="Button" color={buttonColor}/>
        </View>

        <View style={styles.buttonRow}>
          <Button title="Button" color={buttonColor}/>
          <Button title="Button" color={buttonColor}/>
        </View>
        
      </View>
      <View style = {styles.inputContainer}>

      </View>
    </View>
  );
};

const buttonColor = "gray";

const styles = StyleSheet.create({
  imageContainer: {
    backgroundColor: "pink",
    flex: 1
  },
  buttonGrid: {
    backgroundColor: "green",
    flex: 1,
    flexDirection: "column",
    justifyContent: "space-evenly",
  },
  buttonRow: {
    backgroundColor: "blue",
    flexDirection: "row",
    justifyContent: "space-evenly",
  },
  inputContainer: {
    backgroundColor: "purple",
    flex: 2
  },
  icon: {
    height: "50",
    width: "50"
  },
  button: {
    backgroundColor: "red"
    //height: "10%",
    //width: "50%",
  },
  image: {
    //width: "50px",
    //height: "50px"
  },
});

export default App;
