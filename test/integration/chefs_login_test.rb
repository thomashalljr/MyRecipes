require "test_helper"

class ChefsLoginTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "thomas", email: "thall1286@gmail.com", password: "password")
  end

  test "invalid login is rejected" do
    get new_chef_session_path

    assert_template "devise/sessions/new"
    post chef_session_path, params: {chef: {email: " ", password: " "}}

    assert_template "devise/sessions/new"
    assert_not flash.empty?
    assert_select "a[href=?]", new_chef_session_path
    assert_select "a[href=?]", destroy_chef_session_path, count: 0
    get root_path

    assert_empty flash
  end

  test "valid login credentials accepted and begin session" do
    get new_chef_session_path

    assert_template "devise/sessions/new"
    post chef_session_path, params: {chef: {email: @chef.email, password: @chef.password}}

    assert_redirected_to root_path
    follow_redirect!

    assert_redirected_to recipes_path
    follow_redirect!

    assert_template "recipes/index"
    assert_not flash.empty?
    assert_select "a[href=?]", new_chef_session_path, count: 0
    assert_select "a[href=?]", destroy_chef_session_path
    assert_select "a[href=?]", chef_path(@chef)
    assert_select "a[href=?]", edit_chef_registration_path
  end
end
