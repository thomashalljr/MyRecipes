require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  def setup
    @ingredient = Ingredient.create!(name: "chicken")
  end

  test "ingredient should be valid" do
    assert_predicate @ingredient, :valid?
  end

  test "name should be present" do
    @ingredient.name = " "

    assert_not @ingredient.valid?
  end

  test "name shouldn't be less than 3 characters" do
    @ingredient.name = "a" * 2

    assert_not @ingredient.valid?
  end

  test "name shouldn't be more than 25 characters" do
    @ingredient.name = "a" * 26

    assert_not @ingredient.valid?
  end
end
