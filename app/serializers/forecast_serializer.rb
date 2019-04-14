class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attribute :current_weather do
    attributes :current_temperature,
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

  attribute :hourly_forecast do
    # Come back to this, consider nested serializer?
  end
end
