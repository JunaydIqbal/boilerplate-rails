module Types
  module Users
    class UpdateAttributes < Types::BaseInputObject
      argument :id, ID, required: false
      argument :manipulate_access, Types::Users::AccessAttributes, required: false
      argument :update_profile, Types::Users::ProfileAttributes, required: false
    end
  end
end