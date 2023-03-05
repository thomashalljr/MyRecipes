require "test_helper"

class IngredientsTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "thomas", email: "thomashalljunior@gmail.com",
      password: "password", password_confirmation: "password", admin: true)
    @recipe = Recipe.create(name: "vegetable saute", description: "great vegetable saute, add vegetable and oil", chef: @chef)
    @ingredient = Ingredient.create!(name: "chicken")
    @ingredient2 = Ingredient.create!(name: "turkey")
    @recipe_ingredient = RecipeIngredient.create!(recipe_id: 1, ingredient: @ingredient)
  end

  test "should get ingredients index" do
    get ingredients_url

    assert_response :success
  end

  test "should get ingredients listing" do
    get ingredients_path

    assert_template "ingredients/index"
    assert_select "a[href=?]", ingredient_path(@ingredient), text: @ingredient.name.try(:capitalize)
    assert_select "a[href=?]", ingredient_path(@ingredient2), text: @ingredient2.name.try(:capitalize)
  end

  test "should get ingredients show" do
    sign_in_as(@chef, "password")
    get ingredient_path(@ingredient)

    assert_template "ingredients/show"
    assert_match @ingredient.name.capitalize, response.body
    assert_match @recipe.description, response.body
    assert_match @chef.chefname.capitalize, response.body
    assert_select "a[href=?]", edit_recipe_path(@recipe), text: "Edit this recipe"
    assert_select "a[href=?]", recipe_path(@recipe), text: "Delete this recipe"
  end

  test "create new valid ingredient" do
    sign_in_as(@chef, "password")
    get new_ingredient_path

    assert_template "ingredients/new"
    name_of_ingredient = "sausage"
    assert_difference "Ingredient.count", 1 do
      post ingredients_path, params: {ingredient: {name: name_of_ingredient}}
    end
    follow_redirect!

    assert_match name_of_ingredient.capitalize, response.body
  end

  test "reject invalid ingredient submissions" do
    sign_in_as(@chef, "password")
    get new_ingredient_path

    assert_template "ingredients/new"
    assert_no_difference "Ingredient.count" do
      post ingredients_path, params: {ingredient: {name: " "}}
    end
    assert_template "ingredients/new"
    assert_select ".alert-alert"
  end
end
