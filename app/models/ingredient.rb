class Ingredient < ApplicationRecord
  before_validation :lowercase

  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients

  validates :name, presence: true, length: {minimum: 3, maximum: 25}
  validates :name, uniqueness: true

  scope :name_asc, -> { order("name asc") }
  scope :for_navbar, -> { limit(10) }

  private

  def lowercase
    self.name = name.downcase
  end
end
