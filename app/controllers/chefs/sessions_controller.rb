class Chefs::SessionsController < Devise::SessionsController
  def create
    cookies.encrypted[:chef_id] = chef_id if chef_id
    super
  end

  private

  def chef_id
    Chef.select(:id).where(email: params[:chef][:email]).first.try(:id)
  end
end
