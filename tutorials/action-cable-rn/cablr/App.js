/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View
} from 'react-native';
import ActionCable from 'react-native-actioncable';

const cable = ActionCable.createConsumer('ws://localhost:3000/cable');

export default class App extends Component<{}> {
  constructor() {
    super();
    this.state = {
      messages: []
    };
  }

  componentDidMount() {
    const addMessage = (message) => {
      const messages = this.state.messages.slice();
      messages.push(message);
      this.setState({ messages });
    }
    cable.subscriptions.create({
      channel: 'RoomChannel',
      room: 'test_room_channel'
    },
    {
      received(data) {
        addMessage(data.message);
      }
    })
  }

  render() {
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>
          Cablr: Message Receiver
        </Text>
        {this.state.messages.map((message, idx) => (
          <Text key={message + idx}>
            { message }
          </Text>
        ))}
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
});
