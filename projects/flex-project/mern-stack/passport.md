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