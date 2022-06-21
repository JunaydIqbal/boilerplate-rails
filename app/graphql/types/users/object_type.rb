module Types
  module Users
    class ObjectType < Types::BaseObject
      field :id, ID, null: false
      field :email, String, null: false
      field :first_name, String, null: false
      field :last_name, String, null: false
      field :phone_no, String, null: false
      field :role, String, null: false
      field :image_url, String, null: true
      field :revoke_access, Boolean, null: false
      field :deleted, Boolean, null: false

      def image_url
        if object.image.attached?
          Rails.application.routes
            .url_helpers.rails_blob_url(object.image, only_path: true)
        end
      end
    end
  end
end