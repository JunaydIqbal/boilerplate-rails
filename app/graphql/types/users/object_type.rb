module Types
  module Users
    class ObjectType < Types::BaseObject
      field :id, ID, null: false
      field :email, String, null: false
      field :first_name, String, null: false
      field :last_name, String, null: false
      field :phone_no, String, null: false
      field :role, String, null: false
    end
  end
end