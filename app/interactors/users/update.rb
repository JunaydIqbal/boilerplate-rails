module Users
  class Update < BaseInteractor
    
    def call
      @user = User.find(context.user_id)
      @user.profile_picture = generate_blob! if context.user_params[:profile_picture].present?
      @user.update!(context.user_params.except(:profile_picture))
      context.user = @user
    rescue ActiveRecord::RecordNotFound => e
      context.fail!(error: e.message)
    end
    
    private
      
      def generate_blob!
        file = context.user_params[:profile_picture] 
        ActiveStorage::Blob.create_and_upload!(
          io: file,
          filename: file.original_filename,
          content_type: file.content_type
        )
      end
  end
end