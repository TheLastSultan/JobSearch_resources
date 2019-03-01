## Express Routing

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