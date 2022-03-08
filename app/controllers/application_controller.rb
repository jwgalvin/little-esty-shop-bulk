class ApplicationController < ActionController::Base


  def three_holidays
    @holidays = HolidayFacade.find_holidays
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
