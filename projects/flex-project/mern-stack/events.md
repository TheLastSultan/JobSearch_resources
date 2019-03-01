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