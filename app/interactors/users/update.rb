module Users
  class Update < BaseInteractor
    
    def call
      @user = User.find_by(id: context.user_id)
      @user.image = generate_blob! if context.user_params[:image].present?
      @user.update!(context.user_params.except(:image))
      # if @user.created_by_invite? && !@user.invitation_accepted?
      #   send_email_invitation!
      # end
      context.user = @user
    rescue => e
      context.fail!(error: e.message)
    end
    
    private
    
      # def send_email_invitation!
      #   @user.deliver_invitation
      # end
      
      def generate_blob!
        file = context.user_params[:image] 
        ActiveStorage::Blob.create_and_upload!(
          io: file,
          filename: file.original_filename,
          content_type: file.content_type
        )
      end
  end
end