module Users
  class ResendInvitation < BaseInteractor
    def call
      @user = User.find(context.user_params[:id])
      @user.update!(context.user_params.except(:id))
      send_email_invitation! if @user.created_by_invite? && !@user.invitation_accepted?
      context.user = @user
    rescue => e
      context.fail!(error: e.message)
    end
    
    private
    
      def send_email_invitation!
        @user.deliver_invitation
      end
  end
end