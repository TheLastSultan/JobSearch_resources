require 'google/api_client/client_secrets'

# Houses helper methods for other controllers
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def setup_client(access_token = false, refresh_token = false)
    client_options = { web: {
      client_id:      ENV['GOOGLE_CLIENT_ID'],
      client_secret:  ENV['GOOGLE_CLIENT_SECRET'],
      redirect_uri:   ENV['GOOGLE_REDIRECT_URI']
    } }

    client_options[:web][:access_token] = access_token if access_token
    client_options[:web][:refresh_token] = refresh_token if refresh_token

    client_secrets = Google::APIClient::ClientSecrets.new(client_options)
    @client = client_secrets.to_authorization
  end

  def refresh_token(user)
    @client.fetch_access_token!
    user.update_attributes(
      access_token: @client.access_token,
      refresh_token: @client.refresh_token
    ) if @client.refresh_token
  end

  def setup_calendar(user)
    setup_client(user.access_token, user.refresh_token)
    refresh_token(user)
    @calendar_service = Google::Apis::CalendarV3::CalendarService.new
  end

  def list_calendars
    response = @calendar_service.list_calendar_lists({options: {authorization: @client}})
    render json: response.to_json
  end
end
