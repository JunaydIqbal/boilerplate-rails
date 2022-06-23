module DeviseResources
  class ResetPassword < BaseInteractor
    def call
      check_password_fields
      # Enable conditional logic when you have multiple devise models
      klass = User # context.klass == "Customer" ? Customer : User
      @resource = klass.reset_password_by_token(
        reset_password_token: resource_params[:token],
        password: resource_params[:password],
        password_confirmation: resource_params[:password_confirmation]
      )
      check_reset_process!
    rescue => e
      context.fail!(error: e.message)
    end
    
    private
    
      def resource_params
        context.resource_params[:set_password_attributes].to_h
      end

      def check_password_fields
        if resource_params[:password] != resource_params[:password_confirmation]
          raise "Password confirmation doesn't match password!"
        end
      end
      
      def generate_token!
        token_interactor = DeviseResources::GenerateToken.call(resource: @resource)
        
        if token_interactor.success?
          context.token = token_interactor.token
        else
          context.fail!(error: token_interactor.error)
        end
      end
      
      def check_reset_process!
        unless @resource.new_record?
          generate_token!
          context.resource = @resource
        else
          raise 'Invalid Token!'
        end
      end
  end
end