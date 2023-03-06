module Users
  class Update < BaseInteractor
    
    def call
      @user = User.find(context.user_id)
      @user.image = generate_blob! if context.user_params[:image].present?
      authenticated_via_old_password? ? context.fail!(error: "Invalid operation: The new password cannot be the same as the old password") : @user.update!(context.user_params.except(:image))
      # if @user.created_by_invite? && !@user.invitation_accepted?
      #   send_email_invitation!
      # end
      context.user = @user
    rescue ActiveRecord::RecordNotFound => e
      context.fail!(error: e.message)
    end
    
    private
    
      # def send_email_invitation!
      #   @user.deliver_invitation
      # end
      
      def new_password_provided?
        context.user_params[:password]
      end
      
      def generate_blob!
        file = context.user_params[:image] 
        ActiveStorage::Blob.create_and_upload!(
          io: file,
          filename: file.original_filename,
          content_type: file.content_type
        )
      end

      def authenticated_via_old_password?
        @user.valid_password? (new_password_provided?) if new_password_provided?
      end
  end
end