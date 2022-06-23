module DeviseResources
  class Register < BaseInteractor
    def call
      @resource = initialize_resource
      persist_resource_and_respond
    end

    private

      def resource_name
        context.klass.downcase
      end

      def initialize_resource
        # Uncomment and adjust the code below for multiple devise models
        # context.klass == "Customer" ? 
          # Customer.new(context.resource_params) :
          # User.new(context.resource_params)
        User.new(context.resource_params)
      end


      def generate_token
        DeviseResources::GenerateToken.call(resource: @resource, remember_me: context.resource_params[:remember_me])
      end

      def check_token_response!
        @token_interactor.success? ? 
          context.token = @token_interactor.token :
          context.fail!(error: @token_interactor.error)
      end

      def persist_resource_and_respond
        if @resource.save
          context[resource_name] = @resource
          @token_interactor = generate_token
          check_token_response!
        else
          context.fail!(error: @resource.errors.full_messages.join(', '))
        end
      end
  end
end