class Api::V1::UsersController < ApplicationController 
  skip_before_action :authenticate_token!

  def create
    initialize_render_concern(create_user_interactor)

    render_result_serializer
  end

  private

  def create_user_interactor
    UserInteractor::Create.call(user_params: user_params)
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def serializer_method
    UserSerializer
  end
end