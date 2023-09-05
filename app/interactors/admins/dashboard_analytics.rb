module Admins
  class DashboardAnalytics < BaseInteractor
    def call
      build_analytics_data
    rescue => e
      context.fail!(error: e.message)      
    end

    private

    def build_analytics_data
      context.new_users_count = new_users_count
      context.users_count = users_count
      context.active_users_count = active_users_count
      context.revoked_users_count = revoked_users_count
    end

    def new_users_count
      # Users created in last 30 days
      User.user.active.where(created_at: (30.days.ago.to_date..Date.today.end_of_day)).count
    end

    def users_count
      User.user.count
    end

    def active_users_count
      User.user.active.where("last_sign_in_at > ?", 7.days.ago.to_datetime).count
    end

    def revoked_users_count
      User.where(revoke_access: true).count
    end
  end
end