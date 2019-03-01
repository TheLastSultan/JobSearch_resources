# Google OAuth2 Login for Rails
## (no OmniAuth/Devise gems needed)

One of the most common ways to make it easier for a user to create an account and use your app is to allow them to login with an account they already have (Google, Facebook, LinkedIn, etc). Utilizing a third-party for logging in can have additional benefits, for instance:
* One-click login
* Access to third-party services (Friends list, Drive, Calendar)
* No additional passwords for your user to remember

Most services that allow apps to utilize their authorization service use an open-source standard called OAuth (and more commonly, the updated OAuth2). There are many gems that can handle most of the hard work of integrating an OAuth2 login for you, but they require a learning curve in and of themselves, and can hide some of the details of the OAuth2, making it harder to understand exactly what is happening.

This tutorial will walk through the process of integrating a Sign-in with Google feature, and will also show how to access a user's calendar on their behalf. We will not be using the Devise or OmniAuth gems in our Rails app.

## Setting Up Rails

To start, we'll generate a basic rails app.

![new rails app](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/create-rails-app.png)

Then we will add the gems we need: google-api-client (for communicating with Google) and figaro (for securing our API keys). This tutorial was written for google-api-client `~> 0.10.0`. Be sure to run `bundle install`!

![figaro and google gems](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/add-gems.png)

The figaro gem needs to be installed before it will work.

![install figaro](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/install-figaro.png)

Once installed, the figaro gem provides us with an `application.yml` file in our config folder. This file is automatically added to our `.gitignore` file to make sure we don't accidentally share our API keys with bad people on the internet. We will use this file later.

## Setting Up The Google API

Head on over to [the Google Developer Console](https://console.developers.google.com).

Create a new app.

![create app step 1](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/create-google-app-1.png)

---

Give it a name.

![create app step 2](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/create-google-app-2.png)

---

Now that we have an app, we need to enable the APIs we will use. We will want to save some user information in our database (email, first_name, etc.), so we will enable the PeopleV1 API. We will also enable the CalendarV3 API to allow us to manage our user's calendars.

After the APIs have been enabled, we need to create some credentials. Google will provide two credentials to us to let Google know who we are and what we should have access to. We'll store these on our server and **NEVER** share them with our users.

Let's add some credentials for a web app.

![add-google-cred-1](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/add-google-cred-1.png)

---

Make sure to select OAuth Client ID as our type.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/add-google-cred-2.png)

---

We will need to give the basics information to the consent screen. This will be shown to users whenever they login/signup. The minimum information you need here is your email address and the name of your app.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/add-google-cred-3.png)

---

Make sure you select the appropriate type of application (for this example, we are making a Web Application).

We'll name this client "Local Development" and set the Authorized JavaScript origin to be the root URI of our local Rails app.

We also need to add an Authorized Redirect URI. When users login with Google, the will be temporarily redirected to Googles servers. Once they have authenticated with Google, they will be redirected to the Authorized Redirect URI, and an **access code** will be attached to the query string. It will be our responsibility to capture that access code.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/add-google-cred-4.png)

---

After click **Create**, a window will pop up with our two API Secret codes. We will add these to our `application.yml`. It's a good idea to add our redirect URI here, as well.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/add-secrets.png)

---

## Authenticating

Now that we have our Secret Codes, we need to get set up with the `google-api-client` gem. The docs provided by Google for this Ruby gem are pretty lacking, but you can find them [here](https://developers.google.com/api-client-library/ruby/auth/web-app). For a better understanding, you are better off tearing into the gem itself on [Google's GitHub](https://github.com/google/google-api-ruby-client/). This tutorial will try to give as much context as possible to help you understand Google's pattern.

### ApplicationController

We'll start with the `ApplicationController`, and create a method that will set up our app to make authenticated requests as a client.

First, we need to require the ClientSecrets module from the `google-api-client` gem.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/require-google-gem.png)

---

Then we'll create a `setup_client` method that can accept an `access_token` and a `refresh_token` (we'll discuss these more, later). In this method, we'll create an options hash, nesting the `client_secret`, `client_id`, and `redirect_uri` (the ones we stored in our `application.yml`) under the key, `web`.

We will also add the `access_token` and `refresh_token` to the options hash if they are provided.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/application-setup-client.png)

---

Next, we'll create a new instance of `ClientSecrets` with the options hash that we made.

Lastly, we'll create and auth_client from our instance and save it as an instance variable. We'll use this `@client` to make our requests in other places in our app.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/application-setup-finished.png)

---

### AuthController

We'll need to create a controller to handle the various steps in our auth pattern.

```$ rails g controller auth```

The typical Google OAuth2 flow goes as follows:
1. User clicks a link on your website
2. You redirect them to Google's server using a specially formed http request.
3. User enters info into Google's form.
4. If successful, Google will redirect the user to the `redirect_uri` we provided and append an access code to the query string. Ex. `http://localhost:3000/oauth2callback?code=abc123`
5. Our server captures the access code
6. Using the access code, our server requests an `access_token` and `refresh_token` from Google
7. Our server uses the `access_token` and `refresh_token` to obtain more information about the user (email, name, etc.)
8. Once we have all of the information we need, we create or update the user in our database, storing their `access_token` and `refresh_token` along with any other information we need.
9. Our app can now make requests to Google's server on behalf of the user.

In our `AuthController`, let's start by setting up the request to obtain the access code.

Because we will want to manage a user's calendar and name in the future, we need to add the correct scopes. Let's require the `calendar_v3` module.

```ruby
require 'google/apis/calendar_v3'
```

All we need to do is call `#setup_client`, update the scope, use the `@client` to generate the right URI, and redirect the user to that URI. We will need the `profile`, `email`, and `calendar` scopes in order to obtain the appropriate permissions for users.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/scope.png)

---

Before we go any further, let's make sure we set up our routes.

We will need an initial route that will trigger `#fetch_code` and redirect our user to Google's server.

We will also need a route that matches our `redirect_uri` to capture the access code.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/routes.png)

---

We will also need to create a User model to store the user's name, email, and tokens. Make sure to run your migrations.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/add-user-model.png)

---

With the model made, and the routes setup, we can return to the AuthController to create our `#oauth2callback`.

Once again, we'll start by calling `#setup_client`.

Then, we will grab the access code from the query string and assign it to the `@client`. With the access code, `@client` can fetch the access/refresh tokens.

![](https://assets.aaonline.io/fullstack/job-search/tutorials/simple-rails-app/readme_assets/oauth2callback-1.png)

---

We still do not have the user's email address or name. Let's write a helper method to do that for us.

We'll need to require the `people_v1` module at the top of our AuthController file.

```ruby
require 'google/apis/people_v1'
```

We'll name our method `#request_email_and_name`.

The first thing we need to do is create a new instance of `PeopleService`.

```ruby
  people = Google::Apis::PeopleV1
  people_service = people::PeopleService.new
```

We'll also need to create an options hash, letting Google know what information we need to get back (see [here](https://github.com/google/google-api-ruby-client/blob/master/generated/google/apis/people_v1/service.rb) for more info). Under the `options` keyword, we also need to include an authorization hash, passing in our `@client`.


```ruby
people_options = {
  request_mask_include_field: 'person.emailAddresses,person.names',
  options: { authorization: @client }
}
```

We can then use `people_service#get_person` to fetch `people/me` (which will return information about the current authorized user), passing in our options hash. Since this is the last line of our method, the response is automatically returned.

```ruby
def request_email_and_name
  people = Google::Apis::PeopleV1
  people_service = people::PeopleService.new
  people_options = {
    request_mask_include_field: 'person.emailAddresses,person.names',
    options: { authorization: @client }
  }
  people_service.get_person('people/me', people_options)
end
```

Back in `#oauth2callback`, we can call `#request_email_and_name` and use the result create or update a user. The whole thing might look something like this:

```ruby
def oauth2callback
  setup_client
  @client.code = params[:code]
  @client.fetch_access_token!
  @user = User.new(access_token: @client.access_token, refresh_token: @client.refresh_token)
  response = request_email_and_name
  if create_or_update_user(response)
    render json: @user
  else
    render json: @user.errors.full_messages
  end
end

def request_email_and_name
  people = Google::Apis::PeopleV1
  people_service = people::PeopleService.new
  people_options = {
    request_mask_include_field: 'person.emailAddresses,person.names',
    options: { authorization: @client }
  }
  people_service.get_person('people/me', people_options)
end

def create_or_update_user(response)
  email = response.email_addresses[0].value
  @user = User.find_by(email: email)
  if @user.nil?
    first_name = response.names[0].given_name
    @user = User.new(email: email, first_name: first_name)
  end
  @user.access_token = @client.access_token
  @user.refresh_token ||= @client.refresh_token
  @user.save
end
```

## Grabbing a User's Calendars

Now that we can grab the information we need from a user, let's use that information to return a list of the user's calendars.

In our ApplicationController, let's add another helper method to refresh our tokens if they have expired.

```ruby
def refresh_token(user)
  @client.fetch_access_token!
  user.update_attributes(
    access_token: @client.access_token,
    refresh_token: @client.refresh_token
  ) if @client.refresh_token
end
```

Then, we'll make a method to create an instance of CalendarService.

```ruby
def setup_calendar(user)
  setup_client(user.access_token, user.refresh_token)
  refresh_token(user)
  @calendar_service = Google::Apis::CalendarV3::CalendarService.new
end
```

Finally, we'll make a method to render the JSON response of our request for the user's calendars.

```ruby
def list_calendars
  response = @calendar_service.list_calendar_lists({options: {authorization: @client}})
  render json: response.to_json
end
```

To test it out, we can change our `AuthController#oauth2callback` to render a user's calendars whenever they log in.

```ruby
def oauth2callback
  setup_client
  @client.code = params[:code]
  @client.fetch_access_token!
  @user = User.new(access_token: @client.access_token, refresh_token: @client.refresh_token)
  response = request_email_and_name
  if create_or_update_user(response)
    # render json: @user
    setup_calendar(@user)
    list_calendars
  else
    render json: @user.errors.full_messages
  end
end
```

You should now be able to start up your Rails app, navigate to http://localhost:3000/login, sign up with Google, and see JSON with your personal Google Calendars.

## Moving Forward

In your own apps, you probably won't want to render a list of calendars EVERY time your user logs in. You will probably want a CalendarController, and some actual views.

You might also want a way to keep a user logged in. In past apps, we have used session tokens to track users, but a better method (especially when working with OAuth2 or a separate backend/frontend) is to use JSON Web Tokens (JWTs). Try combining a [JWT athentication](https://www.sitepoint.com/authenticate-your-rails-api-with-jwt-from-scratch/) with your new Google login.


### More Info
* [Google on OAuth](https://developers.google.com/+/web/api/rest/oauth)
* [Google OAuth2 Playground](https://developers.google.com/oauthplayground)
* [Google API Explorer](https://developers.google.com/apis-explorer/)
* [Figaro docs](https://github.com/laserlemon/figaro)