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