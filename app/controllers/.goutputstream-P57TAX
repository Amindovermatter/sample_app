class UsersController < ApplicationController
  def new
	user.new(user_params)
	
  end
  def user_params
	params.require(:user).permit(:name,:email,:password,:password_confirmation)
  end
end
