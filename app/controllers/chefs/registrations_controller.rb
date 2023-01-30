class Chefs::RegistrationsController < Devise::RegistrationsController
  protected

  def after_update_path_for resource
    edit_chef_registration_path
  end
end
