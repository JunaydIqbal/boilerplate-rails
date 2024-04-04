module Admins
  class AllUsers < BaseInteractor
    
    def call
      @users = get_users
      context.all_users = users_data_in_format
    rescue => e
      context.fail!(error: e.message)
    end

    private

      def params
        context.params
      end

      def page
        params.dig(:page)
      end

      def per_page
        params.dig(:per_page)
      end

      def user_klass
        case params.dig(:type)
        when "ADMIN"
          Users::Admin
        when "ASSESSOR"
          Users::Assessor
        when "CLIENT"
          Users::Client
        else
          User
        end
      end

      def filter_by_status!
        @users = @users.send(params.dig(:status).downcase)
      end

      def get_users
        user_klass.search(params.dig(:filter, :keyword))
      end
    
      def users_data_in_format
        filter_by_status! if params.dig(:status).present?
        set_pagination!
        {
          all_users: @users,
          total_pages: @users.total_pages || 0,
          next_page: @users.next_page || 0,
          prev_page: @users.prev_page || 0
        }
      end

      def set_pagination!
        @users = @users.page(page).per(per_page)
      end
  end
end