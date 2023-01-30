require "test_helper"

class IngredientsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "thomas", email: "thomashalljunior@gmail.com",
      password: "password", password_confirmation: "password", admin: true)
    @recipe = Recipe.create(name: "vegetable saute", description: "great vegetable saute, add vegetable and oil", chef: @chef)
    @ingredient = Ingredient.create!(name: "chicken")
    @recipe_ingredient = RecipeIngredient.create!(recipe_id: 1, ingredient: @ingredient)
  end

  test "reject invalid ingredient update" do
    sign_in_as(@chef, "password")
    get edit_ingredient_path(@ingredient)

    assert_template "ingredients/edit"
    patch ingredient_path(@ingredient), params: {ingredient: {name: " "}}

    assert_template "ingredients/edit"
    assert_select "h2.panel-title"
    assert_select "div.panel-body"
  end

  test "successfully edit an ingredient" do
    sign_in_as(@chef, "password")
    get edit_ingredient_path(@ingredient)

    assert_template "ingredients/edit"
    updated_name = "updated ingredient name"
    patch ingredient_path(@ingredient), params: {ingredient: {name: updated_name}}

    assert_redirected_to @ingredient
    assert_not flash.empty?
    @ingredient.reload

    assert_match updated_name, @ingredient.name
  end
end
