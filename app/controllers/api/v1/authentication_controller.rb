class Api::V1::AuthenticationController < ApplicationController
  def create
    initialize_render_concern(create_authentication_interactor)

    render_result_serializer
  end

  private

  def create_authentication_interactor
    AuthenticateInteractor::Create.call(login_params: login_params)
  end

  def login_params
    params.require(:user).permit(:email, :password)
  end

  def serializer_method
    UserSerializer
  end
end