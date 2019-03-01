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