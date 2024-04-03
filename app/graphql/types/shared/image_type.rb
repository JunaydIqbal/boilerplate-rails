module Types
  module Shared
    class ImageType < GraphQL::Schema::Object
      field :id, ID, null: false
      field :url, String, null: false
    end
  end
end