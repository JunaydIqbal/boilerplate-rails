module Types
  class MutationType < Types::BaseObject
    # User fields
    field :register_user, mutation: Mutations::Users::RegisterUser
    field :login_user, mutation: Mutations::Users::LoginUser
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :update_password, mutation: Mutations::Users::UpdatePassword
    field :destroy_user, mutation: Mutations::Users::DestroyUser
    
    field :create_invitation, mutation: Mutations::Users::CreateInvitation
    field :resend_invitation, mutation: Mutations::Users::ResendInvitation
    field :set_password, mutation: Mutations::Users::SetPassword
    field :send_reset_password_instructions, mutation: Mutations::Users::SendResetPasswordInstructions
    
    # Admin fields
    field :impersonate_as_user, mutation: Mutations::Admins::ImpersonateAsUser
    field :modify_access_user, mutation: Mutations::Admins::ModifyAccessUser
    
    # Mutations for RSpec tests
    field :order_generator, mutation: Mutations::Support::OrderGenerator if Rails.env.test?

    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World"
    # end
  end
end
