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