class ApplicationController < ActionController::API
  include RenderConcern
  include PaginationConcern

  attr_reader :current_user
  before_action :authenticate_token!

  private

  def render_result_serializer(index: false)
    return if render_error?

    index ? render_for_index : render_for_single
  end

  def render_error?
    return render_error(@result.errors, @error_status) unless @result.success?

    false
  end

  def render_error(errors, status)
    render json: { errors: errors }, status: status
  end
  
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

  def serializer_method
    model_name = self.class.to_s.gsub('Controller', '').demodulize.singularize

    "#{model_name}Serializer".constantize
  end
end
