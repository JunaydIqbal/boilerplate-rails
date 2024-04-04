module Types
  module Filters
    class FilterAttributes < Types::BaseInputObject
      argument :keyword, String, required: false
    end
  end
end