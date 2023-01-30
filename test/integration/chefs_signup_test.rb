require "test_helper"

class ChefsSignupTest < ActionDispatch::IntegrationTest
  test "should get signup path" do
    get new_chef_registration_path

    assert_response :success
  end

  test "reject an invalid signup" do
    get new_chef_registration_path

    assert_no_difference "Chef.count" do
      post chefs_path, params: {chef: {chefname: " ", email: " ", password: "password",
                                       password_confirmation: " "}}
    end

    assert_template "devise/registrations/new"
    assert_select "h1", "Sign up", "Sign up heading not found"
  end

  test "accept valid signup" do
    get new_chef_registration_path

    assert_difference "Chef.count", 1 do
      post chefs_path, params: {chef: {chefname: "thomas", email: "thall1286@gmail.com", password: "password",
                                       password_confirmation: "password"}}
    end

    assert_redirected_to root_path
    follow_redirect!

    assert_redirected_to recipes_path
    follow_redirect!

    assert_template "recipes/index"
    assert_not flash.empty?
  end
end
