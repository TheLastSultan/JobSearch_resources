Rails.application.routes.draw do
  post 'send', to: 'messages#send'
end
