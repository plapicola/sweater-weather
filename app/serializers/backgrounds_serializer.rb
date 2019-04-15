class BackgroundsSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :url
end
