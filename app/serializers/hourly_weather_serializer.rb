class HourlyWeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :hour,
             :temperature,
             :weather
end
