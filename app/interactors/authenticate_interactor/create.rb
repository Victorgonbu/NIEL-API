class AuthenticateInteractor::Create
    include Interactor

    delegate :login_params, to: :context

    def call
        context.output = get_user
    end

    def get_user
        user = User.find_by_email(login_params[:email])
        return user if user&.password == login_params[:password]

        context.fail!(errors: ['Invalid email or password'], error_status: :unauthorized)
    end
end