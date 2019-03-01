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