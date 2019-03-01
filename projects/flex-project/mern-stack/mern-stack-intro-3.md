# Deploying to Heroku

Read on to learn how to deploy your MERN stack app to Heroku.

## Managing Keys

We don't ever want to push our keys to GitHub or Heroku - that would allow anyone to access our database and change whatever they wanted. Let's setup our project to use environment variables when the app is deployed. Start by making two new files in your config folder - ```keys_dev.js``` and ```keys_prod.js```. Let's setup our production keys file to use environment variables from Heroku:

```JavaScript
// keys_prod.js
module.exports = {
  mongoURI: process.env.MONGO_URI,
  secretOrKey: process.env.SECRET_OR_KEY
}
```

We can just paste over the code from our old keys file into ```keys_dev.js```:

```JavaScript
// keys_dev.js
module.exports = {
  mongoURI: 'mongodb://<dbuser>:<dbpassword>@ds123456.mlab.com:12345/databasename',
  secretOrKey: 'secret'
}
```

Now, let's reconfigure ```keys.js``` to use one keys file or the other depending on the environment we are in:

```JavaScript
// keys.js
if (process.env.NODE_ENV === 'production') {
  module.exports = require('./keys_prod');
} else {
  module.exports = require('./keys_dev');
}
```

Don't forget to .gitignore ```keys_dev```. We'll need to push ```keys_prod``` to Heroku - our references to the environment variables won't expose any sensitive information.

Before moving on, test your app locally to make sure it still works.

## Heroku Setup

* Install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) if you haven't already.
* Now, you can login to your Heroku account by running ```heroku login```. Follow the prompts to sign into your account.
* Let's create a Heroku application by running ```heroku create```. This will return a URL string for your new app.
* Refreshing your [Heroku dashboard](dashboard.heroku.com/apps) in the browser, you will see your newly created app listed. Click on it.
* Go the app settings and click on 'Reveal Config Vars.' Set the two new variables we configured in the last step - ```MONGO_URL``` and ```SECRET_OR_KEY```.
* Click on the 'Deploy' tab and scroll down to the bottom of the page. Copy the code used to add the heroku remote (it will look something like ```heroku git:remote -a your-app-name```). Paste it into the terminal and run it.

Don't push to Heroku quite yet - we need to take a few steps to configure React first.

## Deployment

In production, we don't want to run two servers. We'll need to use the static build folder in the frontend to serve up our React app. Head over to ```app.js``` and import path from Express:

```JavaScript
const path = require('path');
```

Now let's tell our server to load the static build folder in production:

```JavaScript
if (process.env.NODE_ENV === 'production') {
  app.use(express.static('frontend/build'));
  app.get('/', (req, res) => {
    res.sendFile(path.resolve(__dirname, 'client', 'build', 'index.html'));
  })
}
```

We want to build our assets on Heroku so that we don't have to run ```npm run build``` every time we push. Let's do this by adding a new script in the ```package.json``` of our server directory:

```JavaScript
// package.json

"scripts": {
  // ...
  // ...
  // This tells npm not to install everything, instead of only the dev dependencies, and to run our install and build commands on push
  "heroku-postbuild": "NPM_CONFIG_PRODUCTION=false npm install --prefix client && npm run build --prefix client"
}
```

## Push to Heroku

* Add and commit your project to GitHub.
* Run ```git push heroku master```.
* Wait for it...
* When all of your scripts have finished building, run ```heroku open``` to see your app in the browser.
* We are still using our mLab database, so you should be able to login with users you have already created.
* Test your app and make sure all of your functionality is still present.

That's it! Your app is live on the web.
