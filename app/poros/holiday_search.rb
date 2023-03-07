require_relative 'holiday'
require './app/services/swagger_service'

class HolidaySearch
	def self.holiday_information
		service.holidays.map do |data|
			Holiday.new(data)
		end
	end

	def self.service
		SwaggerService.new
	end
end