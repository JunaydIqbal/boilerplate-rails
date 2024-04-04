module Types
  module Users
    class UsersPagination < Types::BaseObject
      field :total_pages, Int, null: true
      field :next_page, Int, null: true
      field :prev_page, Int, null: true
      field :all_users, [Types::Users::ObjectType], null: false
    end
  end
end