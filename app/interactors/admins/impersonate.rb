module Admins
  class Impersonate < BaseInteractor
    def call
      grab_resource
      generate_token!
    end

    private

    def grab_resource
      @resource = User.find_by(role: "user", id: context.user_id)
      context.fail!(error: "Invalid User ID!") unless @resource.present?
    end

    def generate_token!
      token_result = DeviseResources::GenerateToken.call(
        resource: @resource, 
        remember_me: false
      )

      if token_result.success?
        context.impersonated_token = token_result.token
        context.user = @resource
      else
        context.fail!(error: token_result.error)
      end
    end
  end
end