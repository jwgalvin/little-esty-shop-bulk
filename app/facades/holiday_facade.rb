class HolidayFacade
  def self.find_holidays
    json = HolidayService.look_for_holidays
    holidays = json.map do |data|
      Holiday.new(data)
    end
    holidays.first(3)
  end
end
