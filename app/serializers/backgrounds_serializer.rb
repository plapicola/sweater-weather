class BackgroundsSerializer
  include FastJsonapi::ObjectSerializer
  set_type :background
  attributes :id, :url
end
