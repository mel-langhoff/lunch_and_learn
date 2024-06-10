class TouristSiteSerializer
  include JSONAPI::Serializer

  set_id { nil }
  set_type :tourist_site

  attribute :name do |object|
    object[:name]
  end

  attribute :address do |object|
    object[:address]
  end

  attribute :place_id do |object|
    object[:place_id]
  end
end