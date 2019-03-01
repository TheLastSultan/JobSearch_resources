# MERN Stack Setup

The principles of building an app in the MERN stack will be familiar to you given your experience in Rails and JavaScript. However, there are some new concepts that you will need to familiarize yourself with before you are ready to build your app. This guide will walk you through setting up the skeleton of your new project.

## Visual Studio Code

You may wish to adopt [VS Code](https://code.visualstudio.com/) as the text editor for your MERN stack application. You will find that VS Code is much faster and more extendable than Atom. It also does a better job of providing you with useful hints and auto-completion features while you code.

After downloading, you may want to consider installing the following extensions:

* Atom Keymap (to keep your familiar keyboard shortcuts)
* Bracket Pair Colorizer (self explanatory)
* ES7 React/Redux/GraphQL/React-Native snippets (provides shortcuts for creating React components)
* Prettier (auto-formatter)
* Live Server (Launch a development local server with live reload features)
* Node.js Modules Intellisense (Autocompletes Node.js modules in import statements)

## mLab

Before we start creating our backend, let's setup our database. We will be using [mLab](https://mlab.com/), which is a free service (at the basic tier) allowing us to host our database online. Follow these steps to setup your database:

* Go to the website and create an account
* At the top right of the page, click 'Create New'
* Select Amazon Web Services as your cloud provider
* Choose 'US East' as your region
* On the next page, name your database whatever you'd like
* Your new deployment will now show up on the dashboard. Click on it.
* Create a new user by clicking on the 'Users' tab
  * Choose a secure username and password you will easily remember
  * Click 'Create'
* At the top of the page there is a line which says "To connect using a driver via the standard MongoDB URI." Take a look at the string underneath - you will be using it later to connect to your database from the app.

## Basic Setup

To start, create a folder for your application and open it with VS Code. In the terminal, run ```npm init```. Follow the prompts to fill out information about your app and choose ```app.js``` as your entry point. When you are done, notice that a file named ```package.json``` has been added to your root directory.

### Installing Dependencies

You can install a node dependency by running ```npm install dependency-name```. Rather than installing them one at a time, you can type ```npm install dependency1 dependecy2 dependency3```. Your project will likely require some unique dependencies. For now, install the following:

* express (the main framework)
* mongoose (to connect and interact with MongoDB)
* passport (for authentication)
* passport-jwt (for JSON web tokens)
* jsonwebtoken (to generate the tokens)
* body-parser (to parse data from requests)
* bcryptjs (this one should be familiar)
* validator (for database validations)

Let's also install a dev dependency, nodemon, to watch our application for changes. Do this by running ```npm install -D nodemon```.

Take a look at your ```package.json```. You will notice that the dependencies have been added to this file.

### Creating the Server

Create a file in your root directory called ```app.js``` if it was not generated automatically. Within it, write the following:

```JavaScript
const express = require("express");
const app = express();
```

This creates a new Express server. Now, let's setup a basic route so that we can render some information on our page. Add the following to your file:

```JavaScript
app.get("/", (req, res) => res.send("Hello World"));
```

Before we can run the server, we need to tell our app which port to run on. Keeping in mind that we will later be deploying our app to Heroku, which requires us to run our server on ```process.env.PORT```, add the following line to ```app.js```:

```JavaScript
const port = process.env.PORT || 5000;
```

Locally our server will now run on ```localhost:5000```.

Finally, let's tell Express to start a socket and listen for connections on the path. Do so by adding the following line to your file:

```JavaScript
app.listen(port, () => console.log(`Server is running on port ${port}`));
```

This will also log a success message to the console when our server is running successfully.

Now open your terminal and run ```node app```. If you have followed the steps correctly you will see your success message: 'Server running on port 5000.' Open up ```localhost:5000``` in Chrome and you should see the text 'Hello World'!

### Using nodemon

Change the `Hello World` message in ```app.js```, save the file, and refresh the page. You'll notice that the message does not change. We will need to use nodemon to watch for changes and update the page.

Open ```package.json``` and find the following line:

```JavaScript
"scripts": {
  "test": "echo \"Error: no test specified\" && exit 1"
}
```

We don't actually need the "test" script. Delete it and replace it with the following code so that your scripts line looks like this:

```JavaScript
"scripts": {
  "start": "node app.js",
  "server": "nodemon app.js"
}
```

Running ```npm run start``` will accomplish the same result as before. However, if you instead run ```npm run server```, you'll notice that the server will watch for changes and log a success message. Once you refresh the web page your changes will be reflected successfully.

## Mongoose

Let's connect our database to mLab. Recall the string you saw at the end of the mLab setup (it looks something like ```mongodb://<dbuser>:<dbpassword>@ds123456.mlab.com:12345/databasename```). Head back to mLab and find it - we will need it for this part of the setup.

* Create a new directory named 'config'
* Make a new file within that directory called ```keys.js```
* Add the following code to ```keys.js```:

```JavaScript
module.exports = {
  mongoURI: 'mongodb://<dbuser>:<dbpassword>@ds123456.mlab.com:12345/databasename'
            //Make sure this is your own unique string
}
```

* Make sure to replace ```dbuser``` and ```dbpassword``` with the username and password you created during the mLab setup.
* **Important:** If you have already created a Git repository, do not commit at this stage. You don't want to push your private username and password to GitHub, and it will be difficult to roll back later.
* Head back to ```app.js```. At the top of the file, import Mongoose: ```const mongoose = require('mongoose');```
* On the line after the one where you instantiated ```app```, import your key by typing  ```const db = require('./config/keys').mongoURI;```
* On the next line, we will connect to MongoDB using Mongoose:

```JavaScript
mongoose
  .connect(db)
  .then(() => console.log("Connected to MongoDB successfully"))
  .catch(err => console.log(err));
```

As long as you have followed the above steps successfully and entered the correct username and password, you should see your success message in the console. That's it! Mongoose is up and running.

## Adding a .gitignore

If you have not done so already, now is a good time to create a GitHub repository for your project so that you can start getting credit for your commits. Once you have done so, add a ```.gitignore``` file to your root directory. You will want to ignore your ```node_modules``` directory (since it is so large) as well as your ```keys.js``` file:

```JavaScript
/config/keys.js
/node_modules
```

Don't forget to commit early and often!

## Routes

At this point, we will start using the Express router so that we can separate our resources. In this tutorial we will create routes for ```users``` and ```events```. At this point you should be thinking about some of the routes you will need in your own project.

* Create a ```routes``` folder in your root directory.
* Create a folder within ```routes``` called ```api```.
* Create JavaScript files for each of your initial routes: ```users.js``` and ```events.js```.
* Follow this template to setup a test route for each file:

```JavaScript
const express = require("express");
const router = express.Router();

router.get("/test", (req, res) => res.json({ msg: "This is the users route" }));

module.exports = router;
```

NB: The callback for every Express route requires a request and response as arguments

* In ```app.js```, after the other items you have already imported, import your routes:

```JavaScript
const users = require("./routes/api/users");
const events = require("./routes/api/events");
```

* At some point in the file, after the line where you instantiated ```app```, tell Express to use your newly imported routes:

```JavaScript
app.use("/api/users", users);
app.use("/api/events", events);
```

Try visiting ```localhost:5000/api/users/test``` - you should see the JSON you entered in the route's callback function. Check the other routes and make sure they are working as well.

Lastly, let's import body parser to ```app.js``` so that we can parse the JSON we send to our frontend:

```JavaScript
const bodyParser = require('body-parser');
```

We'll also need to setup some middleware for body parser:

```JavaScript
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
```

You may want to read more about [Express routing](https://expressjs.com/en/guide/routing.html).

## User Auth

Let's start with the basics - allowing users to create an account.

### The User Model

Let's create a model for our users - each resource needs to have a Mongoose model with a schema.

* Create a new directory called 'models'
* By convention, model files in Mongoose are singular and start with a capital letter. Create a file in ```models``` called ```User.js```
* At the top of the file, import Mongoose. We will also need to require the Mongoose Schema:

```JavaScript
const mongoose = require('mongoose');
const Schema = mongoose.Schema;
```

Now, let's think ahead to the information we need to require from a user and setup our schema:

```JavaScript
const UserSchema = new Schema({
  name: {
    type: String,
    required: true
  },
  email: {
    type: String,
    required: true
  },
  password: {
    type: String,
    required: true
  },
  date: {
    type: Date,
    default: Date.now
  }
})
```

Let's not forget to export our model:

```JavaScript
module.exports = User = mongoose.model('users', UserSchema);
```

Before moving on, read about [defining models in Mongoose](https://mongoosejs.com/docs/2.7.x/docs/model-definition.html).

### Registration

Let's head back to our users route file and setup a route for user registration. Let's start by importing bcrypt:

```JavaScript
const bcrypt = require('bcryptjs');
```

And the User model:

```JavaScript
const User = require('../../models/User');
```

Now let's setup a route to register new users:

```JavaScript
router.post('/register', (req, res) => {
  // Check to make sure nobody has already registered with a duplicate email
  User.findOne({ email: req.body.email })
    .then(user => {
      if (user) {
        // Throw a 400 error if the email address already exists
        return res.status(400).json({email: "A user has already registered with this address"})
      } else {
        // Otherwise create a new user
        const newUser = new User({
          name: req.body.name,
          email: req.body.email,
          password: req.body.password
        })
      }
    })
})
```

The above code block will return an error if there is already a user registered with that email. Assuming that there is no user with that email, we can then save the user in the database.  But first, we do not want to store the password in plain text.  Instead, we want to store the user with a salted and encrypted password hash.

Let's use bcrypt to salt and hash our new user's password before storing it in the database and saving the user (make sure to put this in the 'else' statement in the previous code block):

```JavaScript
bcrypt.genSalt(10, (err, salt) => {
  bcrypt.hash(newUser.password, salt, (err, hash) => {
    if (err) throw err;
    newUser.password = hash;
    newUser.save()
      .then(user => res.json(user))
      .catch(err => console.log(err));
  })
})
```

* Test whether you can register a new user using [Postman](https://www.getpostman.com/).
* Refreshing mLab, you should see that is has automatically created a users collection. When you click on this you should see that the user you just created now exists in the database.

### Login Functionality

Before starting this section, review the documentation for [jsonwebtoken](https://www.npmjs.com/package/jsonwebtoken).

Let's setup a route in ```users.js``` to allow our users to login:

```JavaScript
router.post('/login', (req, res) => {
  const email = req.body.email;
  const password = req.body.password;

  User.findOne({email})
    .then(user => {
      if (!user) {
        return res.status(404).json({email: 'This user does not exist'});
      }

      bcrypt.compare(password, user.password)
        .then(isMatch => {
          if (isMatch) {
            res.json({msg: 'Success'});
          } else {
            return res.status(400).json({password: 'Incorrect password'});
          }
        })
    })
})
```

The login function functions very similar to how it does in rails.  It will compare the user inputed password with the salted and hashed password in the database.  If the password is incorrect, it will return a status 400 error.

Test your login functionality using Postman with both a correct and incorrect email address. This should return your success message.

Let's setup our JSON web token so that our users can actually sign in and access protected routes. At the top of ```users.js```, import jsonwebtoken:

```JavaScript
const jsonwebtoken = require('jsonwebtoken');
```

Now, let's use jsonwebtoken to sign our token. Start by opening ```keys.js``` and adding a key value pair to our key object:

```JavaScript
module.exports = {
  mongoURI: 'mongodb://<dbuser>:<dbpassword>@ds123456.mlab.com:12345/databasename'
  secretOrKey: 'secret';
}
```

Make sure ```keys.js``` is imported into ```users.js```:

```JavaScript
const keys = require('../../config/keys');
```

Finally, let's setup our payload:

```JavaScript
// users.js
bcrypt.compare(password, user.password)
  .then(isMatch => {
    if (isMatch) {
      const payload = {id: user.id, name: user.name};

      jsonwebtoken.sign(
        payload,
        keys.secretOrKey,
        // Tell the key to expire in one hour
        {expiresIn: 3600},
        (err, token) => {
          res.json({
            success: true,
            token: 'Bearer ' + token
          });
        });
    } else {
      return res.status(400).json({password: 'Incorrect password'});
    }
  })
```

We want to return a signed web token with each ```login``` or ```register``` request in order to "sign the user in" on the frontend. Later, we will learn what to do with the signed token in order for the user's information to persist across multiple requests to the backend. The ```login``` and ```register``` functions should ultimately look like this:

```JavaScript
// users.js
router.post("/register", (req, res) => {
  const { errors, isValid } = validateRegisterInput(req.body);

  if (!isValid) {
    return res.status(400).json(errors);
  }

  User.findOne({ name: req.body.name }).then(user => {
    if (user) {
      errors.name = "User already exists";
      return res.status(400).json(errors);
    } else {
      const newUser = new User({
        name: req.body.name,
        email: req.body.email,
        password: req.body.password
      });

      bcrypt.genSalt(10, (err, salt) => {
        bcrypt.hash(newUser.password, salt, (err, hash) => {
          if (err) throw err;
          newUser.password = hash;
          newUser
            .save()
            .then(user => {
              const payload = { id: user.id, name: user.name };

              jwt.sign(payload, keys.secretOrKey, { expiresIn: 3600 }, (err, token) => {
                res.json({
                  success: true,
                  token: "Bearer " + token
                });
              });
            })
            .catch(err => console.log(err));
        });
      });
    }
  });
});
```

```JavaScript
// users.js
router.post("/login", (req, res) => {
  const { errors, isValid } = validateLoginInput(req.body);

  if (!isValid) {
    return res.status(400).json(errors);
  }

  const name = req.body.name;
  const password = req.body.password;

  User.findOne({ name }).then(user => {
    if (!user) {
      errors.name = "This user does not exist";
      return res.status(400).json(errors);
    }

    bcrypt.compare(password, user.password).then(isMatch => {
      if (isMatch) {
        const payload = { id: user.id, name: user.name };

        jwt.sign(payload, keys.secretOrKeys, { expiresIn: 3600 }, (err, token) => {
          res.json({
            success: true,
            token: "Bearer " + token
          });
        });
      } else {
        errors.password = "Incorrect password";
        return res.status(400).json(errors);
      }
    });
  });
});
```

Test this in Postman to ensure that the user's token is returned upon successful login. Save the token for use in the following section.

### Passport

Before starting this section, review the documentation for [passport-jwt](https://www.npmjs.com/package/passport-jwt).

Most of the logic for our login functionality is complete. However, we will need to use Passport to authenticate our token and construct private routes. Recall that we set up our ```register``` and ```login``` routes to return ```jwt``` web token in the response, and we will be saving that using our application on the frontend.  Eventually, we will want to send the web token back in the header of every API request to our backend.  Passport is able to authenticate that token using different "strategies".  For this project, we will be using ```JwtStrategy``` to authenticate our web token.  `Let's start in ```app.js``` and require Passport:

```JavaScript
const passport = require('passport');
```

Now, let's add the middleware for Passport:

```JavaScript
// You can now delete our 'Hello World' route
app.use(passport.initialize());
```

We also need to setup a configuration file for Passport:

```JavaScript
require('./config/passport')(passport);
```

Go ahead and create this config file (```passport.js```) in the 'config' directory. We're going to follow the documentation from the reading at the beginning of this section to setup our Passport configuration:

```JavaScript
// passport.js

const JwtStrategy = require('passport-jwt').Strategy;
const ExtractJwt = require('passport-jwt').ExtractJwt;
const mongoose = require('mongoose');
const User = mongoose.model('users');
const keys = require('../config/keys');

const options = {};
options.jwtFromRequest = ExtractJwt.fromAuthHeaderAsBearerToken();
options.secretOrKey = keys.secretOrKey;

module.exports = passport => {
  passport.use(new JwtStrategy(options, (payload, done) => {
    // This payload includes the items we specified earlier
    console.log(payload);
  }));
};
```

This will only be used if we specify it on a specific route. Head back to ```users.js``` and import Passport:

```JavaScript
const passport = require('passport');
```

Now, let's create our private auth route:

```JavaScript
// users.js
// You may want to start commenting in information about your routes so that you can find the appropriate ones quickly.
router.get('/current', passport.authenticate('jwt', {session: false}), (req, res) => {
  res.json({msg: 'Success'});
})
```

If you test ```localhost:5000/api/users/current``` in Postman without sending a token, you should get an 'Unauthorized' error message.

Now copy the token you saved in the last section - let's use it to test our user authentication in Postman. Add a header in your request to ```localhost:5000/api/users/current```. For the Key, type 'Authorization'. For the Value, paste the token, including the word 'Bearer'. You won't get anything back in Postman, but you should see the user's information logged in the console.

In ```passport.js```, let's return our payload:

```JavaScript
module.exports = passport => {
  passport.use(new JwtStrategy(options, (payload, done) => {
    User.findById(jwt_payload.id)
      .then(user => {
        if (user) {
          // return the user to the frontend
          return done(null, user);
        }
        // return false since there is no user
        return done(null, false);
      })
      .catch(err => console.log(err));
  }));
};
```

Now, head back to ```users.js```. We need to actually return the user in the authentication route:

```JavaScript
router.get('/current', passport.authenticate('jsonwebtoken', {session: false}), (req, res) => {
  res.json({
    id: req.user.id,
    name: req.user.name,
    email: req.user.email
  });
})
```

Querying for your current user in Postman, you should see a response with the your current user object.

### Validation

Before starting this section, review the documentation for [validator](https://github.com/chriso/validator.js/).

Validator is an easy way to put our model level validations in the same place.

Create a new folder in your root directory called 'validation'. Within it, create three new files - ```login.js```, ```register.js```, and ```is-empty.js```. The first two files will contain our validations, while the third will be a custom function we will use to check whether a given string consists of valid input:

```JavaScript
// is-empty.js
const isEmpty = value =>
  value === undefined ||
  value === null ||
  (typeof value === 'object' && Object.keys(value).length === 0) ||
  (typeof value === 'string' && value.trim().length === 0);

module.exports = isEmpty;
```

Following the documentation for validator, let's setup the validations for user login and registration.

```JavaScript
// login.js

const Validator = require('validator');
const isEmpty = require('./is-empty');

module.exports = function validateLoginInput(data) {
  let errors = {};

  data.email = !isEmpty(data.email) ? data.email : '';
  data.password = !isEmpty(data.password) ? data.password : '';

  if (!Validator.isEmail(data.email)) {
    errors.email = 'Email is invalid';
  }

  if (Validator.isEmpty(data.email)) {
    errors.email = 'Email field is required';
  }

  if (Validator.isEmpty(data.password)) {
    errors.password = 'Password field is required';
  }

  return {
    errors,
    isValid: isEmpty(errors)
  };
};
```

```JavaScript
// register.js

const Validator = require('validator');
const isEmpty = require('./is-empty');

module.exports = function validateRegisterInput(data) {
  let errors = {};

  data.name = !isEmpty(data.name) ? data.name : '';
  data.email = !isEmpty(data.email) ? data.email : '';
  data.password = !isEmpty(data.password) ? data.password : '';
  data.password2 = !isEmpty(data.password2) ? data.password2 : '';

  if (!Validator.isLength(data.name, { min: 2, max: 30 })) {
    errors.name = 'Name must be between 2 and 30 characters';
  }

  if (Validator.isEmpty(data.name)) {
    errors.name = 'Name field is required';
  }

  if (Validator.isEmpty(data.email)) {
    errors.email = 'Email field is required';
  }

  if (!Validator.isEmail(data.email)) {
    errors.email = 'Email is invalid';
  }

  if (Validator.isEmpty(data.password)) {
    errors.password = 'Password field is required';
  }

  if (!Validator.isLength(data.password, { min: 6, max: 30 })) {
    errors.password = 'Password must be at least 6 characters';
  }

  if (Validator.isEmpty(data.password2)) {
    errors.password2 = 'Confirm Password field is required';
  }

  if (!Validator.equals(data.password, data.password2)) {
    errors.password2 = 'Passwords must match';
  }

  return {
    errors,
    isValid: isEmpty(errors)
  };
};
```

In your users route, import your newly created validations:

```JavaScript
// users.js

const validateRegisterInput = require('../../validation/register');
const validateLoginInput = require('../../validation/login');
```

Now, at the top of our registration route, let's validate the user's input:

```JavaScript
// users.js

router.post('/register', (req, res) => {
  const { errors, isValid } = validateRegisterInput(req.body);

  if (!isValid) {
    return res.status(400).json(errors);
  }

  User.findOne({ email: req.body.email })
    .then(user => {
      if (user) {
        // Use the validations to send the error
        errors.email = 'Email already exists';
        return res.status(400).json(errors);
      } else {
        const newUser = new User({
          name: req.body.name,
          email: req.body.email,
          password: req.body.password
        })
      }
    })
})
```

Repeating the process the login route:

```JavaScript
router.post('/login', (req, res) => {
  const { errors, isValid } = validateLoginInput(req.body);

  if (!isValid) {
    return res.status(400).json(errors);
  }

  const email = req.body.email;
  const password = req.body.password;

  User.findOne({email})
    .then(user => {
      if (!user) {
        // Use the validations to send the error
        errors.email = 'User not found';
        return res.status(404).json(errors);
      }

      bcrypt.compare(password, user.password)
        .then(isMatch => {
          if (isMatch) {
            res.json({msg: 'Success'});
          } else {
            // And here:
            errors.password = 'Incorrect password'
            return res.status(400).json(errors);
          }
        })
    })
})
```

Try to register a new user in Postman with invalid input. This should return the corresponding error message you specified earlier. Test out various other registration fields, such as mismatched passwords and invalid email addresses, to make sure your validations are working correctly for both registration and login.

## Events

Before you start this section, you will want to review [routing in Express](https://expressjs.com/en/guide/routing.html).

Utilizing your knowledge of validator, create an events validator. It should look something like:

```JavaScript
// validation/events.js

const Validator = require('validator');
const isEmpty = require('./is-empty');

module.exports = function validateEventInput(data) {
  let errors = {};

  data.text = !isEmpty(data.text) ? data.text : '';

  if (!Validator.isLength(data.text, { min: 10, max: 300 })) {
    errors.text = 'Event name must be between 10 and 300 characters';
  }

  if (Validator.isEmpty(data.text)) {
    errors.text = 'Text field is required';
  }

  return {
    errors,
    isValid: isEmpty(errors)
  };
};
```

Following a now-familiar pattern, let's setup a model for our events:

```JavaScript
// models/Event.js

const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const EventSchema = new Schema({
  user: {
    type: Schema.Types.ObjectId,
    ref: 'users'
  },
  text: {
    type: String,
    required: true
  },
  name: {
    type: String
  },
  date: {
    type: Date,
    default: Date.now
  }
});

module.exports = Event = mongoose.model('event', EventSchema);
```

Let's make routes to retrieve all events and single events:

```JavaScript
// routes/api/events.js
// Go ahead and delete the test route

const express = require('express');
const router = express.Router();
const mongoose = require('mongoose');
const passport = require('passport');

const Event = require('../../models/Event');
const validateEventInput = require('../../validation/event');

router.get('/', (req, res) => {
  Event.find()
    .sort({ date: -1 })
    .then(events => res.json(events))
    .catch(err => res.status(404).json({ noeventsfound: 'No events found' }));
});

router.get('/:id', (req, res) => {
  Event.findById(req.params.id)
    .then(event => res.json(event))
    .catch(err =>
      res.status(404).json({ noeventfound: 'No event found with that ID' })
    );
});
```

Finally, we will create a protected route for a user to post events:

```JavaScript
// routes/api/events.js

router.post(
  '/',
  passport.authenticate('jwt', { session: false }),
  (req, res) => {
    const { errors, isValid } = validateEventInput(req.body);

    if (!isValid) {
      return res.status(400).json(errors);
    }

    const newEvent = new Event({
      text: req.body.text,
      name: req.body.name,
      user: req.user.id
    });

    newEvent.save().then(event => res.json(event));
  }
);
```

If this were a real app, we would want to create an authenticated route to delete posts, and perhaps some additional routes to add comments or likes. However, for the sake of this tutorial, we are going to keep things simple and stick with the ability to retrieve and create posts.

Use Postman to test your new routes.

## Next Steps

* Think through your database schema
* Finish setting up your backend skeleton
  * Models
  * Routes
  * Validations
* Populate your database with some dummy data

## Further Reading

* [Promises in JavaScript](https://developers.google.com/web/fundamentals/primers/promises)
* [SQL vs. NoSQL](https://www.janbasktraining.com/blog/sql-vs-nosql/)
* [Async functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/async_function)

## [Part 2 - Connecting the Backend to React](./mern-stack-intro-2.md)
