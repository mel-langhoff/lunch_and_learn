class FavoriteSerializer
  include JSONAPI::Serializer

  set_type :favorite

  attributes :country, :recipe_title, :recipe_link, :created_at
end