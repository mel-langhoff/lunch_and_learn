class Favorite < ApplicationRecord
  belongs_to :user

  validates_presence_of :user_id, :recipe_link, :recipe_title, :country
end