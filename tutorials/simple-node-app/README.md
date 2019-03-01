# OAuth 2.0 Tutorial

## Quick Launch

Clone the repository and run `npm install` in the console. Follow Phase 0, setting up a Google Cloud Project and a PostgreSQL database. Copy your clientID and client secret from Google into `backend/util.js`. Run `npm start` to start the backend server, and visit http://localhost:3000/ to log in with your Google account.

## About

In this tutorial, we will build the simplest possible Node/Express web app that lets users log in with their Google accounts and persist their session to the browser. Many tutorials on the topic can be very comprehensive and focused on implementing OAuth with large frameworks on the frontend and ORM's on the backend. Not this one. Our goal will be to have it up and running in 30 min, in a form that's easily adaptable to fit any Node backend.

## Phase 0

First we will get everything set up for success. Start by visiting https://console.developers.google.com/projectselector/apis/library and selecting 'Create'. This will help us get a new clientID for our app, which verifies to Google that we're authorized to use their API. NOTE: This will be a slightly different process for each OAuth provider (Facebook, Twitter, etc...), but will often consist of similar steps.

Enter a project name and click 'Create', you will be given a project ID. Save it somewhere, it may be useful for your app later. (Not for ours!)
![one](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-node-app/assets/one.png)

---

Next, select Google+ API in the list of API's and enable it. Google+ will provide us with basic user information and a profile photo for our simple app, but you can access all of Google's APIs here and use them for your applications.
![two](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-node-app/assets/two.png)

---

Go to the left menu and click 'Credentials'. Select 'Create Credentials' and 'OAuth client ID'.
![three](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-node-app/assets/three.png)

---

You will be told that you that you must create a consent screen before editing Credentials. Click 'Configure consent screen' in the top right corner. We will do the minimum, just enter your project name and 'Save'. Use this menu to customize the consent form Google sends you when requesting sensitive information for your future apps.
![four](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-node-app/assets/four.png)

---

Now you are at the credentials page. Select 'Web Application' and fill in your project name and whichever path you would like Google to send a user's information under 'Authorized redirect URIs'. We are using `auth/google/callback` After you are done, hit 'Create'.
![five](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-node-app/assets/five.png)

---

Create a new directory titled `simple-node-app`. Copy your clientID and client secret into an object like the one below in a new file `util.js`.

``` javascript
//util.js

export const googleConfig = {
  clientID: 'client-id-here',
  clientSecret: 'client-secret-here',
  callbackURL: 'http://localhost:3000/auth/google/callback'
};
```

### DB Setup

We are now setup to use Google+ API. However, before we can start building, we must have a database to work with. For this tutorial, make sure you have PostgreSQL installed and running on our computer.

From the command line, run `psql` to open PostgreSQL. Type in the following commands to create a new database titled `oauthtutorial` with a `users` table containing 5 fields. Don't forget the semicolons.

1. `CREATE DATABASE oauthtutorial;`
2. `\c oauthtutorial`
3. `CREATE TABLE users (id SERIAL PRIMARY KEY, name VARCHAR(80) NOT NULL, email VARCHAR(80) NOT NULL, avatar VARCHAR(200), googleId VARCHAR(80) NOT NULL, token VARCHAR(200) NOT NULL);`

### Node Setup

Exit Postgres and run `npm init --yes` in our new directory to create a `package.json`.

#### Node Modules We Will Use

- `babel-cli` --- transpiles our fancy ES6 code into less fancy ES5 code
- `babel-preset-es2015` --- ES6 preset
- `body-parser` --- for sending form data in express requests
- `ejs` --- for rendering HTML embedded with javascript
- `express` --- for running our backend server
- `express-session` --- for storing our session tokens
- `nodemon` --- watches for changes and restarts our backend server
- `passport` --- for Oauth
- `passport-google-oauth` --- for Google implementation specifically
- `pg` --- for connecting to our Postgres database and making queries

Run `npm install --save module1 module2 ...` to install the node modules above. Woot! We are ready to start coding.

## Phase 1

Let's create a file called `server.js` and start a basic express server. Put this file in a new directory called `/backend`, along with `util.js`.

``` javascript
import express from 'express';
import bodyParser from 'body-parser';

const app = express();

app.use(bodyParser.urlencoded({ extended: true }));

app.listen(3000, () => {
  console.log('Example app listening on port 3000!');
});
```
This is pretty standard boiler-plate express code, in which we create an `app` express object, add some middleware (more to come), and then serve it on port 3000. You may be curious about what `bodyParser` is doing. This enables frontend forms to ship data along with POST requests to our Express backend. Although we won't have any forms to worry about, it will help you test your database connection with Postman in future apps.

We can try and run this file and start the server with the command `node backend/server.js`, but our ES6 code will cause the server to break. Additionally, it would break every time we updated our code in the future. Let's run the server with `nodemon` so we don't have to worry about ES6 or continually restarting our server. Add the following script under `"start"` to your `package.json`.

``` javascript
"scripts": {
  "test": "echo \"Error: no test specified\" && exit 1",
  "start": "nodemon backend/server.js --exec babel-node --presets es2015"
},
```

Go ahead and run `npm start` in the console from the root directory and verify that everything's working before moving on.

## Phase 2

Now let's test our connection to our database by writing some simple controllers and routes. Make two new files in `/backend`  called `controller.js` and `routes.js`.

Write a controller that will fetch all users in our database. Each Express controller function takes a request and response as its first two arguments, and generally follows these steps:
1. Open a connection to the database. (unless using an ORM)
2. Query the database for the information you need.
3. If found, send the data in the response argument as JSON.
4. If something goes wrong, send an error in the response.
5. Close the connection to the database after all queries are complete so another future connection can be made. (unless using an ORM)

``` javascript
//controller.js

const pg = require('pg');
const connectionString = process.env.DATABASE_URL || 'postgres://localhost/oauthtutorial';

export const getAllUsers = (req, res) => {
  const client = new pg.Client(connectionString);
  client.connect(err => {
    client.query("SELECT * FROM users")
      .then(data => res.status(200).json({ users: data.rows }))
      .then(() => client.end());
  })
};
```

We can quickly set up a test route with the following few lines of code. Any future routes can be listed right inside the `routerConfig` function. This will act as a sort of middleware for our `app` object.
``` javascript
//routes.js

import * as controller from './controller.js';

export const routerConfig = app => {
  app.get('/api/users', controller.getAllUsers);
};

```
Go ahead and import the `routerConfig` function to `server.js` and invoke before the final call to `app.listen`.
``` javascript
//server.js

import express from 'express';
import bodyParser from 'body-parser';
import { routerConfig } from './routes.js';

const app = express();

app.use(bodyParser.urlencoded({ extended: true }));

routerConfig(app);

app.listen(3000, () => {
  console.log('Example app listening on port 3000!');
});
```

Since our backend is being served by nodemon, we can see if there are any users in our database by making a GET request to http://localhost:3000/api/users.

Looks like there's nothing. But if you see an object resembling `{users: []}`, then that means our controller works! Explore writing the entire CRUD cycle in these two files and test with Postman. Add and create dummy users until you're comfortable you've got the hang of controllers. This is how we create simple RESTful API endpoints in Node.js.

## Phase 3

Now that we have some controllers and routes to work with, we can add our passport logic to start making requests for user information right to Google.

The following code is the heart of OAuth for a Node project. Let's put it in new file in `/backend` called `passport.js`. In here, we will create another piece of middleware for our soon-to-exist `passport` object that adds an OAuth2Strategy which uses our app's clientID and client secret for verification. This is fairly confusing, but also fairly standard passport code, with helper methods doing their best to filter out the logic specific to our use of Postgres. In other words, `findUserById` and `findOrCreateUser` are functions that can be rewritten to use another database or ORM, without changing our `passportConfig` logic in any way. Look intently at how the `done` function is passed and used.

``` javascript
//passport.js

import pg from 'pg';
import { OAuth2Strategy as GoogleStrategy } from 'passport-google-oauth';
import { googleConfig } from './util.js';

const connectionString = process.env.DATABASE_URL || 'postgres://localhost/oauthtutorial';

export const passportConfig = (passport) => {
  // used to serialize the user for the session
  passport.serializeUser((user, done) => done(null, user.id));
  // used to deserialize the user
  passport.deserializeUser((id, done) => findUserById(id, done));

  passport.use(new GoogleStrategy({
    clientID: googleConfig.clientID,
    clientSecret: googleConfig.clientSecret,
    callbackURL: googleConfig.callbackURL,
  },
  (token, refreshToken, profile, done) => {
    process.nextTick(() => findOrCreateUser(token, profile, done));
  }));
};

//Helper functions for passportConfig

const findUserById = (id, done) => {
  const client = new pg.Client(connectionString);
  client.connect(err => {
    client.query(`SELECT * FROM users WHERE id=\'${id}\'`)
    .then(
      data => {
        const user = data.rows[0];
        done(null, user);
      },
      err => done(err, null)
    )
    .then(() => client.end());
  });
};

const findOrCreateUser = (token, profile, done) => {
  const client = new pg.Client(connectionString);
  client.connect(err => {
    client.query(`SELECT * FROM users WHERE googleId=\'${profile.id}\'`)
    .then(
      foundUsers => {
        let user = foundUsers.rows[0];
        if (user) {
          done(null, user);
        } else {
          client.query(`INSERT INTO users (name, email, avatar, googleId, token) VALUES (\'${profile.name.givenName}\', \'${profile.emails[0].value}\', \'${photoUrlHelper(profile.photos[0].value)}\', \'${profile.id}\', \'${token}\') RETURNING *`)
          .then(
            createdUsers => done(null, createdUsers.rows[0]),
            err => done(err, null)
          );
        }
      }
    )
    .then(() => client.end());
  });
};

//Google Profile Img url comes with query string tagged on to make image size tiny, so this cuts it off
const photoUrlHelper = url => url.substr(0, url.indexOf('?'));
```

We must add several new routes as well as a second passport argument to `routerConfig` to handle the auth routes that will be using this strategy. Don't worry about the frontend files being sent in `/` and `/profile`, we will add those before we test.

``` javascript
//routes.js

import * as controller from './controller.js';
import path from 'path';

//helper function
const isLoggedIn = (req, res, next) => {
  if (req.isAuthenticated()) {
    return next();
  }
  res.redirect('/');
};

export const routerConfig = (app, passport) => {
  app.get('/api/users', controller.getAllUsers);

  //login route
  app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, '../frontend/login.html'));
  });

  //protected profile route. Try it in your browser when logged out.
  app.get('/profile', isLoggedIn, (req, res) => {
    console.log(req.user);
    res.render(path.join(__dirname, '../frontend/profile.ejs'), {
      user: req.user
    });
  });

  //logout route
  app.get('/logout', (req, res) => {
    //flips the isAuthenticated property sent in the request of successRedirect to false
    req.logout();
    //eliminates token saved by express-session
    req.session.destroy();

    res.redirect('/');
  });

  //google request route, can be altered to include more user information
  app.get('/auth/google',
    passport.authenticate('google', {
      scope : ['profile', 'email']
    })
  );

  //google response route with appropriate redirects
  app.get('/auth/google/callback',
    passport.authenticate('google', {
      successRedirect: '/profile',
      failureredirect: '/'
    })
  );
};
```

## Phase 4

Cleanup time. Let's update our `server.js` to involve this passport logic, and make some views for the frontend so we can test.

Import `passport` and `express-session` as well as our passportConfig function to `server.js`. First pass the `session` middleware to `app.use`. Don't worry about the options for `saveUninitialized` and `resave`, those are required defaults. Then invoke our `passportConfig` function on the `passport` object, which takes in our very own Google Strategy before being sent to `routerConfig` to handle the authentication routes. Finally, invoke `initialize` and `session` on `passport` to complete the backend. See entire `server.js` below.

``` javascript
//server.js

import express from 'express';
import bodyParser from 'body-parser';
import passport from 'passport';
import session from 'express-session';
import { passportConfig } from './passport.js';
import { routerConfig } from './routes.js';

const app = express();

app.use(bodyParser.urlencoded({ extended: true }));

app.use(session({
  secret: 'PutAnythingYouWantHere',
  saveUninitialized: false,
  resave: false,
}));

passportConfig(passport);
app.use(passport.initialize());
app.use(passport.session());

routerConfig(app, passport);

app.listen(3000, () => {
  console.log('Example app listening on port 3000!');
});
```
#### Frontend

To mimic a frontend, we will add a `/frontend` folder alongside our backend with two new files `login.html` and `profile.ejs`. We will use embedded javascript for the profile page to easily incorporate the user's name and profile picture into the rendered XML.

- The login page will present a button that directs to our `auth/google` route.
- The profile page will be a protected route that can only be reached after successfully logging in (protected by the `isLoggedIn` function in `routes.js`), and includes a button to our `/logout` route.

Since your frontend will completely replace these two files, feel free to copy and paste this code and style to your satisfaction.

``` xml
<!-- login.html -->

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>OAuthTutorial</title>
  </head>
  <body>
    <div id="root">
      <h1>Hi I'm your web application. Who are you?</h1>
      <a href="auth/google">
        <button>Google Login</button>
      </a>
    </div>
  </body>
</html>
```

``` xml
<!-- profile.ejs -->

<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Profile</title>
  </head>
  <body>
    <h1 style="display:inline-block">Nice to meet you <%= user.name %></h1>
    <a href="/logout"><button>Logout</button></a>
    <img style="display:block" src=<%= user.avatar %>>
  </body>
</html>
```

And there it is! We've done it! Be sure that all necessary dependencies are installed and included at the top of each file. Visit http://localhost:3000 and test it out! Refresh the page and notice the persistence. You are hereby an OAuth master.

## Conclusion

Using Passport.js for implementing OAuth with a Node.js backend is recommended by most major OAuth providers. Hopefully after successfully completing this tutorial, you can not only implement OAuth in your own Node applications, but also customize the logic here to suit your own needs. A lot of research and effort went into deciding what was and wasn't needed to perform a successful Google login, so that you wouldn't waste valuable time on other tutorials setting up something that doesn't apply to YOUR project.

## More Resources

Great alternative Facebook tutorial:
- https://scotch.io/tutorials/easy-node-authentication-facebook

OAuth2.0 docs:
- https://auth0.com/docs/protocols/oauth2

Passport docs:
- http://passportjs.org/docs
