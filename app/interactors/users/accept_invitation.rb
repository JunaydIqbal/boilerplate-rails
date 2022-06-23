module Users
  class AcceptInvitation < BaseInteractor
    def call
      @user = User.accept_invitation!(
        invitation_token: user_params[:token],
        password: user_params[:password],
        password_confirmation: user_params[:password_confirmation]
      )
      return_user_based_errors unless @user.errors.blank?
      check_for_invitation_acceptance
    rescue => e
      context.fail!(error: e.message)
    end
    
    private
    
      def user_params
        context.user_params[:set_password_attributes].to_h
      end
      
      def generate_token!
        token_interactor = DeviseResources::GenerateToken.call(resource: @user)
        
        if token_interactor.success?
          context.token = token_interactor.token
        else
          context.fail!(error: token_interactor.error)
        end
      end

      def return_user_based_errors
        raise "#{@user.errors.full_messages.join(', ')}"
      end
      
      def check_for_invitation_acceptance
        if @user.invitation_accepted?
          generate_token!
          context.resource = @user
        else
          raise 'Invalid Token!'
        end
      end
  end
end