class Api::V1::AuthenticationController < ApplicationController
  def create 
    @user = User.find_by_email(login_params[:email])
    
    if @user&.password == login_params[:password]
      render json: UserSerializer.new(@user).serializable_hash.to_json, status: 200
    else
      render json: {errors: ['Invalid email or password']}, status: 422
    end
  end

  private
  def login_params
    params.require(:user).permit(:email, :password)
  end
end