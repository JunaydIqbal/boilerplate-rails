module DeviseResources
  class Login < BaseInteractor

    def call
      @resource = grab_resource
      check_for_account_access if suspension_check_needed?
      authenticate!
    rescue => e
      context.fail!(error: e.message)
    end

    private

      def resource_name
        context.klass.downcase
      end

      def grab_resource
        # Uncomment and adjust the code below for multiple devise models
        # @resource = context.klass == "Customer" ? 
        #   Customer.find_by(email: context.email) :
        #   User.find_by(email: context.email)
        User.active.find_by(email: context.resource_params[:email])
      end

      def suspension_check_needed?
        @resource.present? && @resource.is_a?(User)
      end

      def check_for_account_access
        if @resource.revoke_access
          raise 'Account Suspended. Please contact admin to get it enabled!'
        end
      end

      def authenticate!
        if @resource && @resource.valid_password?(context.resource_params[:password])
          context[resource_name] = @resource
          @token_result = DeviseResources::GenerateToken.call(resource: @resource, remember_me: context.resource_params[:remember_me])
          if @token_result.success?
            context.token = @token_result.token
          else
            context.fail!(error: @token_result.error)
          end
        else
          raise 'Invalid Credentials'
        end
      end
      
  end
end