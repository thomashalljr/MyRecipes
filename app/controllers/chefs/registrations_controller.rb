class Chefs::RegistrationsController < Devise::RegistrationsController
  def new
    redirect_to root_path, alert: "Sign up is disabled."
  end

  def create
    redirect_to root_path, alert: "Sign up is disabled."
  end

  protected

  def after_update_path_for resource
    edit_chef_registration_path
  end
end
