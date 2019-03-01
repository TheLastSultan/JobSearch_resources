Rails.application.routes.draw do
    get 'login', to: 'auth#fetch_code'
    get 'oauth2callback', to: 'auth#oauth2callback'
end
