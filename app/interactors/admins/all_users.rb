module Admins
  class AllUsers < BaseInteractor
    include Paginatable

    def call
      @users = get_users
      filter_by_status! if params.dig(:status).present?
      paginate_records(@users)
      context.all_users = users_data_in_format
    rescue => e
      context.fail!(error: e.message)
    end

    private

      def params
        context.params
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

      def get_users
        user_klass.search(params.dig(:filter, :keyword))
      end

      def filter_by_status!
        @users = @users.send(params.dig(:status).downcase)
      end
    
      def users_data_in_format
        {
          all_users: paginated_records,
          total_pages: pagy.pages,
          next_page: pagy.next,
          prev_page: pagy.prev
        }
      end
  end
end
