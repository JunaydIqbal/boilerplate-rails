module Types
  class MutationType < Types::BaseObject
    # User fields
    field :register_user, mutation: Mutations::Users::RegisterUser
    field :login_user, mutation: Mutations::Users::LoginUser
    field :update_user, mutation: Mutations::Users::UpdateUser
    field :destroy_user, mutation: Mutations::Users::DestroyUser
    field :modify_access_user, mutation: Mutations::Users::ModifyAccessUser

    field :create_invitation, mutation: Mutations::Users::CreateInvitation
    field :resend_invitation, mutation: Mutations::Users::ResendInvitation
    field :set_password, mutation: Mutations::Users::SetPassword
    field :send_reset_password_instructions, mutation: Mutations::Users::SendResetPasswordInstructions
    # TODO: remove me
    # field :test_field, String, null: false,
    #   description: "An example field added by the generator"
    # def test_field
    #   "Hello World"
    # end
  end
end
