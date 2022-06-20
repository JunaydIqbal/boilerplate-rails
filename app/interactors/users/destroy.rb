module Users
  class Destroy < BaseInteractor
    def call
      user = User.find_by(id: context.user_id)
      user.destroy # You can replace this with soft destroy logic, for instance; user.update(deleted: true)
      context.user = user
    rescue => e
      context.fail!(error: e.message)
    end
  end
end