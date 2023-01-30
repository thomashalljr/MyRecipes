require "test_helper"

class ChefsEditTest < ActionDispatch::IntegrationTest
  def setup
    @chef = Chef.create!(chefname: "thomas", email: "thomashalljunior@gmail.com",
      password: "password", password_confirmation: "password")
    @chef2 = Chef.create!(chefname: "john", email: "john@gmail.com",
      password: "password", password_confirmation: "password")
    @admin_user = Chef.create!(chefname: "john1", email: "john1@gmail.com",
      password: "password", password_confirmation: "password", admin: true)
  end

  test "reject an invalid edit" do
    sign_in_as(@chef, password)
    get edit_chef_registration_path

    assert_template "devise/registrations/edit"
    patch chef_registration_path, params: {chef: {chefname: " ", email: "thall1286@gmail.com"}}

    assert_template "devise/registrations/edit"

    # Assert that email is still old email
    @chef.reload

    assert_no_match "thall1286@gmail.com", @chef.email
  end

  test "accept valid edit" do
    sign_in_as(@chef, password)
    get edit_chef_registration_path

    assert_template "devise/registrations/edit"
    patch chef_registration_path, params: {chef: {chefname: "thomas1", email: "thall1286test@gmail.com", current_password: password}}

    assert_redirected_to edit_chef_registration_path
    assert_not flash.empty?
    @chef.reload

    assert_match "thomas1", @chef.chefname
    assert_match "thall1286test@gmail.com", @chef.email
  end

  test "accept edit attempt by admin user" do
    sign_in_as(@admin_user, password)
    get edit_chef_registration_path

    assert_template "devise/registrations/edit"
    patch chef_registration_path, params: {chef: {chefname: "thomas2", email: "thomas2@gmail.com", current_password: password}}

    assert_redirected_to edit_chef_registration_path
    assert_not flash.empty?
    @admin_user.reload

    assert_match "thomas2", @admin_user.chefname
    assert_match "thomas2@gmail.com", @admin_user.email
  end

  test "redirect edit attempt by another non-admin user" do
    sign_in_as(@chef2, password)
    updated_name = "joe"
    updated_email = "joe@example.com"
    patch chef_registration_path, params: {chef: {chefname: updated_name, email: updated_email, current_password: password}}

    assert_redirected_to edit_chef_registration_path
    assert_not flash.empty?
    @chef.reload

    assert_match "thomas", @chef.chefname
    assert_match "thomashalljunior@gmail.com", @chef.email
  end

  private

  def password
    "password"
  end
end
