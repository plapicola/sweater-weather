class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :name

  attribute :current_weather do
    # Come back to this, consider nested serializer?
  end

  attribute :hourly_forecast do
    # Come back to this, consider nested serializer?
  end
end
