module DeviseResources
  class SendResetPasswordInstructions < BaseInteractor

    def call
      # Use conditional logic if you have multiple devise models
      # resource = context.klass == "Customer" ? 
      #     Customer.find_by(email: context.email) :
      resource = User.active.find_by(email: context.email)
      
      if resource.present?
        resource.send_reset_password_instructions
        context.resource = resource
      else
        raise "Unable to find user associated with email"
      end
    rescue => e
      context.fail!(error: e.message)
    end
  end
end