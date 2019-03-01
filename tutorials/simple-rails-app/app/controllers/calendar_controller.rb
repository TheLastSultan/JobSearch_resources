require 'google/apis/calendar_v3'

class CalendarController < ApplicationController
  class Calendar
    def initialize(user)
      setup_client(user.access_token, user.refresh_token)
      refresh_token(user)
      @calendar_service = Google::Apis::CalendarV3::CalendarService.new
    end

    def list_calendars
      render json: @calendar_service.list_calendar_lists({options: {authorization: @client}})
    end
  end
end
