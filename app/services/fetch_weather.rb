require 'open_weather'

class FetchWeather
	def self.for_day(date)
		# If required, we could also go into historic data here,
		# since this will only work for up to 16 days in the future.
		# But I'm not sure it even makes sense to display forecast for
		# days long gone.

		options = {
			units: 'metric',
			APPID: 'd35081c3cc9de6d307a107a9651a7313'
		}

		weather = OpenWeather::ForecastDaily.city('Ljubljana, SI', options)
		weather['list'].each do |day|
			dt = Time.at(day['dt']).to_date

			if dt == date
				return day
			end
		end
		return nil
	end
end