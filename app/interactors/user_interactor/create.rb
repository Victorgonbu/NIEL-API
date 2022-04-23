class UserInteractor::Create
    include Interactor

    delegate :user_params, to: :context

    def call
        context.output = create_user
    end

    private

    def create_user
        user = User.new(user_params)
        return user if user.save

        context.fail!(errors: user.errors.full_messages, error_status: :unprocessable_entity)
    end
end