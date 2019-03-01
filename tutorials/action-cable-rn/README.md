# React Native + Rails API + ActionCable

This is a short tutorial that will demonstrate how to make a React Native application connect to a Rails API with ActionCable. This project assumes that you are running your app in an emulator on your local machine. There are notes at the end on things to look out for when deploying these to a production server.

# Rails ActionCable API

Let's start by creating a new rails app in API mode (we don't plan on rendering any HTML).

```bash
rails new cable_backend --api --database=postgresql
```

Enable redis in the gemfile. This step is mainly for production. Rails will use a redis instance to temporarily cache broadcasts, making communication over sockets lightning quick.

```ruby
gem 'redis', '~> 3.0'
```

Then install our gems.

```terminal
cd cable_backend
bundle install
```

Now that the app is created and gems are installed, let's create a channel. We'll name it 'room'.

```terminal
rails g channel room
```

In `app/channels/room_channel.rb`, lets set up the subscribe method to stream from a channel. We'll call it `test_room_channel`. When a user subscribes to our room channel, we'll automatically set them up to listen for broadcasts on the `test_room_channel`.

```ruby
def subscribed
  puts "A user has subscribed!"
  stream_from "test_room_channel"
end
```

Let's go ahead and create a controller and some routes that will allow us to broadcast a message to our subscribers.

```terminal
rails g controller messages
```

In `app/controllers/messages` we will set up a simple method that will take a message from a post request and send that message to all subscribers who are listening to the `test_room_channel`.

```ruby
class MessagesController < ApplicationController
  def send
    ActionCable.server.broadcast 'test_room_channel', message: params[:message]
    render plain: "Message broadcasted!" # This is just to let us know that our request was successful.
  end
end
```

Then, in `config/routes.rb`, we need to add a route that points at the method we just made.

```ruby
Rails.application.routes.draw do
  post 'send', to: 'messages#send'
end
```

---

# React Native

Let's switch gears, and work on our frontend. We'll make sure to cd out of our rails app, because we want to keep our front-end and back-end separate.

```terminal
cd ..
```

Follow the instructions for `Building Projects with Native Code` [here](https://facebook.github.io/react-native/docs/getting-started.html) to get your machine ready to build your app.

Once our machine is set up and we have the `react-native-cli` installed, we initialize a new app. We'll call it `cablr`.

```terminal
react-native init cablr
```

Then we'll cd into our app, and make sure our packages are installed.

```terminal
cd cablr
npm install
```

Then, we need to install the npm package for ActionCable. We could install `actioncable`, but there is an npm package that takes care of a few boilerplate details and makes it easy for us to use in React Native projects. That package is `react-native-actioncable`.

```terminal
npm install --save react-native-actioncable
```

We'll go ahead and re-write the provided `App.js` to have a local `state` which will store our messages, and we'll set the render method to render the messages as `text`.

```jsx
export default class App extends Component<{}> {
  constructor() {
    super(); // You have to call super() before creating a local state
    this.state = {
      messages: []
    };
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
```

Now let's use ActionCable to set the app to subscribe to our channel in the backend.

First, we need to import the ActionCable library. (In `App.js`)

```js
import ActionCable from 'react-native-actioncable';
```

Then we need to initialize our app as a 'consumer'. We can use the returned object to subscribe to specific channels.

```js
const cable = ActionCable.createConsumer('ws://localhost:3000/cable');
```

And now, we'll have the component connect to a specific channel when the component mounts. We'll also set up the callback function which is called any time a the server broadcasts a message.

```jsx
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
```

The whole `App.js` will end up looking like this:

```jsx
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
```

# Test It!

Start your rails server.

```
rails s
```

Start your react app.

```
react-native run-ios
```

Once the app is up, you should see our app title.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/action-cable-rn/readme_assets/screenshot.png)

We can send a message to our app via the terminal, using `curl`.

```
curl -X POST http://localhost:3000/send -H 'content-type: multipart/form-data' -F 'message=Hello React Native!'
```

And you should see your message appear on the app emulator.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/action-cable-rn/readme_assets/demo.gif)

# Notes for Deploying to a Production Server

There are a few things that you will need to be aware of when deploying a Rails app with ActionCable. The first thing is that Rails uses Redis to make ActionCable faster in production. Some hosting sites take extra steps to get a Redis server up and running (Heroku, specifically).

* You may need to enable CORS to allow communication from outside your server (your React Native app, specifically).

* You will need to change the URI in `App.js` to match your hosted production URI.

* You will likely want to use [JWTs](https://www.sitepoint.com/authenticate-your-rails-api-with-jwt-from-scratch/) to secure communication with your backend.
