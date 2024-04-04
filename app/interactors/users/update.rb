module Users
  class Update < BaseInteractor
    before :fetch_user

    def call
      update_user!
      context.user = user
    rescue ActiveRecord::RecordNotFound => e
      context.fail!(error: e.message)
    end

    private

      attr_reader :user

      def fetch_user
        @user = context.user_id.present? ? User.find(context.user_id) : current_user
      end

      def update_user!
        user_attrs = determine_user_attributes
        user.update!(user_attrs)
        update_profile_picture_if_necessary(user_attrs)
      end

      def determine_user_attributes
        if admin_or_superadmin? && context.user_id.present?
          validate_role_update_permission!
          access_or_profile_attributes
        else
          context.user_params.dig(:update_profile).to_h
        end
      end

      def access_or_profile_attributes
        if manipulate_access?
          update_manipulate_access_attrs
        else
          context.user_params.dig(:update_profile).to_h
        end
      end

      def manipulate_access?
        context.user_params.dig(:manipulate_access).present?
      end

      def update_manipulate_access_attrs
        context.user_params.dig(:manipulate_access).to_h.merge(type: identify_role)
      end

      def update_profile_picture_if_necessary(attrs)
        return unless attrs.key?(:profile_picture)

        user.profile_picture = generate_blob!(attrs[:profile_picture])
      end

      def identify_role
        role_type = context.user_params.dig(:manipulate_access, :type)
        case role_type
        when "ADMIN" then "Users::Admin"
        when "ASSESSOR" then "Users::Assessor"
        when "CLIENT" then "Users::Client"
        end
      end

      def validate_role_update_permission!
        if current_user.type == "Users::Admin" && identify_role == "Users::Admin"
          raise "You cannot change a user's role to 'Admin'. Only super admins can do this."
        end
      end

      def admin_or_superadmin?
        ["Users::Admin", "Users::SuperAdmin"].include? current_user.type
      end

      def current_user
        context.current_user
      end
  end
end
