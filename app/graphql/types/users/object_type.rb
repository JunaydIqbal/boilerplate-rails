module Types
  module Users
    class ObjectType < Types::BaseObject
      field :id, ID, null: false
      field :email, String, null: false
      field :full_name, String, null: true
      field :first_name, String, null: false
      field :last_name, String, null: false
      field :phone_no, String, null: false
      field :role, String, null: false
      field :image_url, String, null: true
      field :revoke_access, Boolean, null: false
      field :deleted, Boolean, null: false

      field :invitation_accepted, Boolean, null: false
      field :raw_invitation_token, String, null: false

      def invitation_accepted
        object.invitation_accepted?
      end

      def raw_invitation_token
        object.raw_invitation_token
      end

      def image_url
        if object.image.attached?
          Rails.application.routes
            .url_helpers.rails_blob_url(object.image, only_path: true)
        end
      end
    end
  end
end