class ProfilesController < ApplicationController
  before_action :set_user, only: %i[edit update]

  def show
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end

  def user_params
    params.require(:user).permit(:name)
  end
end
