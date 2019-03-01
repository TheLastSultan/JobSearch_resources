# React Setup

Before starting this section, you will want to review the [Create React App user guide](https://github.com/facebook/create-react-app/blob/master/packages/react-scripts/template/README.md).

Let's start setting up the frontend of our application:

- In your terminal, run `npm install -g create-react-app` - this will install React globally.
  - Update npm if prompted to do so.
- In the root directory of your project, run `create-react-app frontend` - this will install a new React application in a new folder called 'frontend'.
- If you look in the 'frontend' directory, you will notice that it has its own node_modules folder. Make sure to .gitignore this folder.
- When setting up routes for our React app, we don't want to be required to type the full path; we would rather just write something like '/api/users/:id'. To do this we will need to add a key-value pair to the `package.json` **in our frontend folder**: `"proxy": "http://localhost:5000"`
- React runs on its own development server - `localhost:3000`. While we could write separate commands to run each server, this would quickly become rote. We will use an npm package called 'concurrently' to run both servers at once.
- ( As a sidenote, making an axios request with a proxy will first run an API request to ```localhost:300``` and then redirect the request to ```localhost:500```.  You may get a console error saying that the route, ```localhost:300/api/users/``` does not exist.  This error is okay, as axios is making a request to both servers at this point. )
  - Navigate to the root directory of your project
  - Run `npm install concurrently`
  - Add three new scripts to your `package.json`:
    - `"frontend-install": "npm install --prefix frontend"`
      - This will allow users who download your project from GitHub to easily install dependencies from both folders
    - `"frontend": "npm start --prefix frontend"`
    - `"dev": "concurrently \"npm run server\" \"npm run frontend\""`
  - Now, if we type ``npm run dev`in the terminal, both of our servers will start running. You can view the frontend on`localhost:3000```
- You may find the Chrome [React Developer Tools](https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en) and [Redux DevTools](https://chrome.google.com/webstore/detail/redux-devtools/lmhkpmbekcpmknklioeibfkpmmfibljd?hl=en) useful for your project.
- If you installed the 'ES7 React/Redux/GraphQL/React-Native snippets' extension in VS Code, you can run 'rfc => tab' to create a functional component or 'rcc => tab' to create a class component.

### Axios and jwt-decode

Let's add [axios](https://www.npmjs.com/package/axios) and [jwt-decode](https://www.npmjs.com/package/jwt-decode) to our frontend so that we can fetch information from our server and parse the user's token:

- Navigate to your frontend folder
- Run `npm install axios jwt-decode`

### Session Util

For the remainder of this tutorial, let's modify everyone's favorite project project to work with our new backend - [BenchBnb](https://github.com/appacademy/curriculum/tree/master/react/projects/bench_bnb/solution). To follow along, you can copy over the React components and redux pattern from BenchBnb to your own project - we will still be working with the template we downloaded from create-react-app. In this implementation we construct redux in the 'src' folder.

- Our 'util' folder used to only contain AJAX calls to our backend, but we're going to modify it now to save our user's web token to local storage and dispatch the appropriate actions. Let's start out in `session_api_util.js`:

```JavaScript
// frontend/src/util/session_api_util.js

import axios from 'axios';
import jwt_decode from 'jwt-decode';

const $ = window.$;
export const GET_ERRORS = 'GET_ERRORS';
export const CLEAR_ERRORS = 'CLEAR_ERRORS';
export const RECEIVE_CURRENT_USER = 'RECEIVE_CURRENT_USER';

// We can use axios to set a default header
export const setAuthToken = token => {
  if (token) {
    // Apply to every request
    axios.defaults.headers.common['Authorization'] = token;
  } else {
    // Delete auth header
    delete axios.defaults.headers.common['Authorization'];
  }
};
```

This function will set the header for every subsequent axios request.  Recall that in our backend, we are using passport and the ```JwtStrategy``` to autheticate a web token.  This is where the web token is defined in the axios request, and it will be sent to the backend with every request.

How do we get the web token to the frontend in the first place?  We want to create a function that will read user input from a form, and send that to the backend in an axios request.  Let's start by creating a ```registerUser``` pattern.


```JavaScript
// Register User
export const registerUser = (userData, history) => dispatch => {
  axios
    .post('/api/users/register', userData)
    .then(res => {
      // Save to localStorage
      const { token } = res.data;
      // Set token to ls
      localStorage.setItem('jwtToken', token);
      // Set token to Auth header
      setAuthToken(token);
      // Decode token to get user data
      const decoded = jwt_decode(token);
      // Set current user
      dispatch(setCurrentUser(decoded));
    })
    .catch(err =>
      dispatch({
        type: GET_ERRORS,
        payload: err.response.data
      })
    );
};
```

Upon the return of the response.  We can pull the token from the ```res.data``` using object destructuring.  We then want to save the token returned from our ```/api/users/register``` route in the backend to local storage on the frontend.  We want to then call our ```setAuthToken``` function to set the web token in the header of every request.  Let's do the same for our ```loginUser``` function.


```JavaScript
// Login - Get User Token
export const loginUser = userData => dispatch => {
  axios
    .post('/api/users/login', userData)
    .then(res => {
      // Save to localStorage
      const { token } = res.data;
      // Set token to ls
      localStorage.setItem('jwtToken', token);
      // Set token to Auth header
      setAuthToken(token);
      // Decode token to get user data
      const decoded = jwt_decode(token);
      // Set current user
      dispatch(setCurrentUser(decoded));
    })
    .catch(err =>
      dispatch({
        type: GET_ERRORS,
        payload: err.response.data
      })
    );
};

// Set logged in user
export const setCurrentUser = decoded => {
  return {
    type: RECEIVE_CURRENT_USER,
    payload: decoded
  };
};
```

When the user logs out, we want to remove the web token from local storage.

```JavaScript
// Log user out
export const logoutUser = () => dispatch => {
  // Remove token from localStorage
  localStorage.removeItem('jwtToken');
  // Remove auth header for future requests
  setAuthToken(false);
  // Set current user to {} which will set isAuthenticated to false
  dispatch(setCurrentUser({}));
};
```

Let's modify our session reducer to handle our new actions:

```JavaScript
// frontend/src/reducers/session_reducer.js

import {
  RECEIVE_CURRENT_USER,
} from '../util/session_api_util';

const _nullUser = Object.freeze({
  id: null
});

const sessionReducer = (state = _nullUser, action) => {
  Object.freeze(state);
  switch(action.type) {
    case RECEIVE_CURRENT_USER:
      return { id: action.payload.id,
              handle: action.payload.handle,
              email: action.payload.email };
    default:
      return state;
  }
};

export default sessionReducer;
```

As well as our session errors reducer:

```JavaScript
// frontend/src/reducers/session_errors_reducer.js

import {
  GET_ERRORS,
  RECEIVE_CURRENT_USER
} from '../util/session_api_util';

export default (state = [], action) => {
  Object.freeze(state);
  switch (action.type) {
    case GET_ERRORS:
      return action.payload;
    case RECEIVE_CURRENT_USER:
      return [];
    default:
      return state;
  }
};
```

In `index.js`, we're going to configure our store and set our default axios header with our auth token, dispatching our `RECEIVE_CURRENT_USER` action if a token already exists in local storage. We'll also check to see whether the token is expired, and if it is, we will log our user out:

```JavaScript
// frontend/src/index.js

import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import jwt_decode from 'jwt-decode';
import * as APIUtil from './util/session_api_util';
//Components
import configureStore from './store/store';
import App from './App.jsx';
import registerServiceWorker from './registerServiceWorker';

document.addEventListener('DOMContentLoaded', () => {
  let store = configureStore();
  // Check for token
  if (localStorage.jwtToken) {
    // Set auth token header auth
    APIUtil.setAuthToken(localStorage.jwtToken);
    // Decode token and get user info and exp
    const decoded = jwt_decode(localStorage.jwtToken);
    // Set user and isAuthenticated
    store.dispatch(APIUtil.setCurrentUser(decoded));

    // Check for expired token
    const currentTime = Date.now() / 1000;
    if (decoded.exp < currentTime) {
      // Logout user
      store.dispatch(APIUtil.logoutUser());
      // Redirect to login
      window.location.href = '/login';
    }
  }
  const root = document.getElementById('root');
  ReactDOM.render(<App store={store} />, root);
  registerServiceWorker();
});
```

Let's modify our signup form container to use the new utilities we have generated:

```JavaScript
// frontend/src/components/session_form/signup_form_container.js

import { connect } from 'react-redux';
import React from 'react';
import { Link } from 'react-router-dom';
import { registerUser } from '../../util/session_api_util';
import SessionForm from './session_form';

const mapStateToProps = ({ errors }) => {
  return {
    errors: errors.session,
    formType: 'signup',
    navLink: <Link to="/login">log in instead</Link>,
  };
};

const mapDispatchToProps = dispatch => {
  return {
    processForm: (user) => dispatch(registerUser(user)),
  };
};

export default connect(mapStateToProps, mapDispatchToProps)(SessionForm);
```

And finally, head over to your greeting container to import the appropriate action and set the current user correctly:

```JavaScript
// frontend/src/components/greeting/greeting_container.js

import { connect } from 'react-redux';

import { logoutUser } from '../../util/session_api_util';
import Greeting from './greeting';

const mapStateToProps = ({ session }) => {
  return {
    currentUser: session
  };
};

const mapDispatchToProps = dispatch => ({
  logout: () => dispatch(logoutUser())
});

export default connect(
  mapStateToProps,
  mapDispatchToProps
)(Greeting);
```

That's it! You should now be able to register and login users using your React app.  

[Download the skeleton](./benchbnb_auth.zip)

## [Part 3 - Deploying to Heroku](./mern-stack-intro-3.md)
