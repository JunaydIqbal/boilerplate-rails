module Users
  class ForwardInvitation < BaseInteractor
    def call
      check_for_user_existence!
      @user = create_user_invitation
      update_status! if @user.persisted?
      context.user = @user
    rescue => e
      context.fail!(error: e.message)
    end

    private

      def user_params
        context.user_params.to_h
      end

      def invited_by
        context.current_user
      end

      def user_klass
        case user_params.dig(:type)
        when "ADMIN"
          Users::Admin
        when "ASSESSOR"
          Users::Assessor
        when "CLIENT"
          Users::Client
        end
      end

      def user_already_present?
        User.where(email: user_params[:email]).exists?
      end
      
      def check_for_user_existence!
        raise 'Email has already been taken!' if user_already_present?
      end

      def create_user_invitation
        user_klass.invite!(user_params.except(:type), invited_by)
      end

      def update_status!
        @user.update!(invitation_status: "pending")
      end
  end
end