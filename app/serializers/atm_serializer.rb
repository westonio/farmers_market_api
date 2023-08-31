class AtmSerializer
  include JSONAPI::Serializer
  attributes :name, :distance, :address, :lat, :lon
end
