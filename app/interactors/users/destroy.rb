module Users
  class Destroy < BaseInteractor
    def call
      @user = User.find_by(id: context.user_id)
      soft_destroy!
      context.user = user
    rescue => e
      context.fail!(error: e.message)
    end

    private

      def soft_destroy!
        @user.update(deleted: true)
      end
  end
end