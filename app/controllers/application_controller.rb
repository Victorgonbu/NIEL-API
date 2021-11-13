class ApplicationController < ActionController::API
  attr_reader :current_user
  before_action :authenticate_token!

  private
  def authenticate_token!
    payload = JsonWebToken.decode(authToken).first
    @current_user = User.find(payload['sub'])
  rescue
    @current_user = nil
  end
  def authToken
    @authToken ||= request.headers.fetch('Authorization', '').split.last
  end

  def authenticate_admin!
    render json: {errors: ['No valid user']}, status: 400 unless current_user.try(:admin)
  end
end
