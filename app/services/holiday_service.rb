class HolidayService
  def self.holidayz
    url = "https://date.nager.at/swagger/index.html"
    Faraday.new(url)
  end

  def self.look_for_holidays
    response = holidayz.get("https://date.nager.at/api/v3/NextPublicHolidays/US")
    JSON.parse(response.body, symbolize_names: true)
  end
end
