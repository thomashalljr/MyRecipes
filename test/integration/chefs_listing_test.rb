require "test_helper"

class ChefsListingTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "thomas", email: "thomashalljunior@gmail.com",
      password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "john", email: "thall1286@gmail.com",
      password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "john1", email: "john1@gmail.com",
      password: "password", password_confirmation: "password", admin: true)
  end

  test "should get chefs listing" do
    get chefs_path

    assert_template "chefs/index"
    assert_select "a[href=?]", chef_path(@chef), text: @chef.chefname.capitalize
    assert_select "a[href=?]", chef_path(@chef2), text: @chef2.chefname.capitalize
  end

  test "should delete chef" do
    sign_in_as(@admin_user, "password")
    get chefs_path

    assert_template "chefs/index"

    assert_difference "Chef.count", -1 do
      delete chef_registration_path
    end

    assert_redirected_to root_path
    assert_not flash.empty?
  end
end
