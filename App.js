import React, { Component } from 'react'
import { Button } from 'react-native'
import { TextInput, TouchableOpacity, Image, StyleSheet, View, Text } from 'react-native'


import educationcircle from './img/educationcircle.png'

const Home = (props) => {
  return (
    <View style={styles.container}>
      <View style={styles.redbox}>

      <Image style={{height: 200, width: 200}}  
   
      source={require('./img/educationcircle.png')} />

    
      </View>
      <View style={styles.bluebox}>
        <Button title="button"> </Button>
        <Button title="button"> </Button>

      </View>
      <View style={styles.greenbox}>
        <Button title="button"> </Button>
        <Button title="button"> </Button>

      </View>
      <View style={styles.blackbox}>
        <Text>Enter your email: </Text>
        
        <TextInput
          style={styles.input}

          placeholder="Email"
          keyboardType="email-adress"
        >
        </TextInput>
      </View>


    </View>
  )
}

export default Home

const styles = StyleSheet.create({
  container: {
    
  },
  redbox: {
    width: "100%",
    height: "50%",
    justifyContent: 'center',
    alignItems: 'center',
    margin: "auto",
    textalign: "center",
    
    
  },
  bluebox: {
    flexDirection: 'row',
    justifyContent: 'space-evenly',
    margin: 30,
  },
  greenbox: {

    flexDirection: 'row',
    justifyContent: 'space-evenly',
    display: 'flex',
    margin: 30,

  },
  blackbox: {
    display: 'flex', 
    flexDirection: 'row',
    justifyContent: 'center',
    alignItems: 'center',
    margin: 30,
  },
  input: {
    height: 40,
    width: "50%",
    margin: 30,
    borderWidth: 1,
    flexgrow: 2,
  },
})