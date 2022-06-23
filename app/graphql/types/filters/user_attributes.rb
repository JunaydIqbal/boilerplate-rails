module Types
  module Filters
    class UserAttributes < Types::BaseInputObject
      argument :keyword, String, required: false
    end
  end
end