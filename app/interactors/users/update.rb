module Users
  class Update < BaseInteractor
    
    def call
      update_user!
      context.user = @user
    rescue ActiveRecord::RecordNotFound => e
      context.fail!(error: e.message)
    end

    private

      def user_id
        context.user_id
      end

      def user_params
        context.user_params
      end

      def manipulate_access_attrs
        user_params.dig(:manipulate_access).to_h
      end

      def update_profile_attributes
        user_params.dig(:update_profile).to_h
      end

      def current_user
        context.current_user
      end

      def fetch_user
        @user = User.find(user_id)
      end

      def update_user!
        if current_user.type == "Users::Admin" && user_id.present?
          @user = fetch_user
          @user.update!(update_manipulate_access_attrs)
        else
          @user = current_user
          @user.update!(update_profile_attributes)
          @user.profile_picture = generate_blob!(update_profile_attributes[:profile_picture])
        end
        @user
      end

      def identify_role
        case manipulate_access_attrs.dig(:role)
        when "ADMIN"
          "Users::Admin"
        when "ASSESSOR"
          "Users::Assessor"
        when "CLIENT"
          "Users::Client"
        end
      end

      def update_manipulate_access_attrs
        manipulate_access_attrs.merge(
          {
            role: identify_role
          }
        )
      end
  end
end