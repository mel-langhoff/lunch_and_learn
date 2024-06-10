class RecipeSerializer
  include JSONAPI::Serializer

  set_id { nil }
  set_type :recipe

  attribute :label do |object|
    object[:label]
  end

  attribute :url do |object|
    object[:url]
  end

  attribute :image do |object|
    object[:image]
  end

  attribute :country do |object|
    object[:country]
  end

end