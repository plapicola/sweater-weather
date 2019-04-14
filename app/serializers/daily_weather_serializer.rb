class DailyWeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :day,
             :weather,
             :percipitation_chance,
             :max_temperature,
             :min_temperature
end
