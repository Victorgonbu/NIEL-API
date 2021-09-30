class Api::V1::UsersController < ApplicationController 
  skip_before_action :authenticate_token!

  def create
    @user = User.new(user_params)
    if @user.save
      render json: UserSerializer.new(@user).serializable_hash.to_json, status: 200
    else
      render json: {errors: @user.errors.full_messages}, status: 422
    end 
  end

  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end