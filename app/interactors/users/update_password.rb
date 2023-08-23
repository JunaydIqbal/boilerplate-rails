module Users
  class UpdatePassword < BaseInteractor
    def call
      @user = context.current_user
      
      if @user.valid_password?(user_params[:current_password])
        update_password
      else
        raise "Your current password is incorrect!"
      end
    rescue => e
      context.fail!(error: e.message)
    end
    
    private

    def user_params
      context.user_params     
    end

    def update_password
      if @user.update(password: user_params[:password], password_confirmation: user_params[:password_confirmation])
        context.response = true
      else
        context.fail!(error: @user.errors.full_messages.join(", "))
      end
    end
  end
end