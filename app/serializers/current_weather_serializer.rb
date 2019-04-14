class CurrentWeatherSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id,
             :current_temperature,
             :perceived_temperature,
             :max_temperature,
             :min_temperature,
             :current_weather,
             :humidity,
             :visibility,
             :uv_index,
             :current_description,
             :future_description
end
