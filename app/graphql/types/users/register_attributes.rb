module Types
  module Users
    class RegisterAttributes < Types::Users::BaseAttributes # That adds up common user attributes
      argument :remember_me, Boolean, required: true
      argument :terms_and_conditions, Boolean, required: true,
        description: "Acceptance of terms and conditions",
        prepare: ->(value, ctx) do
          unless value
            raise GraphQL::ExecutionError.new("You must accept the terms and conditions")
          end
          value
        end
    end
  end
end