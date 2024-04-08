module Paginatable
  extend ActiveSupport::Concern
  include Pagy::Backend

  included do
    attr_accessor :pagy, :paginated_records
  end

  def paginate(scope)
    self.pagy, self.paginated_records = pagy(scope, page: page, items: per_page)
  end

  private

    def page
      context.params&.dig(:page) || 1
    end

    def per_page
      context.params&.dig(:per_page) || 10
    end
end