module Users
  class Update < BaseInteractor
    
    def call
      @user = User.find(context.user_id)
      @user.image = generate_blob! if context.user_params[:image].present?
      unless check_old_password_is_same?
        @user.update!(context.user_params.except(:image))
      else
        context.fail!(error: "Your password is same with previous!")
      end
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
      
      def get_new_password
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

      def check_old_password_is_same?
        if get_new_password
          @user.valid_password? (get_new_password)
        end
      end
  end
end