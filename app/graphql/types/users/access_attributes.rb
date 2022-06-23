module Types
  module Users
    class AccessAttributes < Types::BaseInputObject
      argument :user_id, ID, required: true
      argument :revoke_access, Boolean, required: true
      argument :deleted, Boolean, required: false
    end
  end
end