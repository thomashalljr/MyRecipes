require "test_helper"

class RecipeTest < ActiveSupport::TestCase
  def setup
    @chef = Chef.create!(chefname: "thomas", email: "thomashalljunior@gmail.com",
      password: "password", password_confirmation: "password")
    @recipe = @chef.recipes.build(name: "vegetable", description: "great vegetable recipe")
  end

  test "recipe without chef should be invalid" do
    @recipe.chef = nil

    assert_not @recipe.valid?
  end

  test "recipe should be valid" do
    assert_predicate @recipe, :valid?
  end

  test "name should be present" do
    @recipe.name = " "

    assert_not @recipe.valid?
  end

  test "description should be present" do
    @recipe.description = " "

    assert_not @recipe.valid?
  end

  test "description shouldn't be less than 5 characters" do
    @recipe.description = "a" * 3

    assert_not @recipe.valid?
  end
end
