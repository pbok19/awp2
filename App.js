/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, {Component} from 'react';
import {Platform, StyleSheet, Text, View, TouchableOpacity, requireNativeComponent} from 'react-native';

const BoseView = requireNativeComponent("BoseView")
const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

//type Props = {};
export default class App extends Component {
  state = {
    count: 1
  };
  increment = () => {
    this.setState({ count: this.state.count + 1 })
  }

  render() {
    return (
      <View style={styles.container}>
        <TouchableOpacity
          style={[styles.wrapper, styles.border]}
          onPress={this.increment}
        >
          <Text style={styles.button}>
            {this.state.count}
          </Text>
        </TouchableOpacity>
        <BoseView style={ styles.wrapper } />
        </View>
    );
  }
}

const styles = StyleSheet.create({
  
  container: {
    flex: 1, alignItems: "stretch", backgroundColor: "white"
  },
  wrapper: {
    flex: 1, alignItems: "center", justifyContent: "center", color: "white"
  },
  border: {
    borderColor: "#eee", borderBottomWidth: 1
  },
  button: {
    fontSize: 50, color: "orange"
  }

});
