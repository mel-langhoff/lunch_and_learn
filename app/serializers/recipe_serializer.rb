class RecipeSerializer
  include JSONAPI::Serializer

  set_id { nil }
  set_type :recipe
  
  # attributes :label, :url, :image
   # :country

end