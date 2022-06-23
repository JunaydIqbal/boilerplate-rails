module Users
  class ForwardInvitation < BaseInteractor
    def call
      check_for_user_existence!
      @user = create_user_invitation
      context.user = @user
    rescue => e
      context.fail!(error: e.message)
    end

    private

      def user_params
        context.user_params
      end

      def user_already_present?
        User.where(email: user_params[:email]).exists?
      end
      
      def check_for_user_existence!
        raise 'Email has already been taken!' if user_already_present?
      end

      def create_user_invitation
        User.invite!(user_params) do |u|
          u.role = 'user'
          # This will skip sending email invitation
          # u.skip_invitation = true
        end
      end
  end
end