module Paginatable
  extend ActiveSupport::Concern
  include Pagy::Backend

  included do
    attr_accessor :pagy, :paginated_records
  end

  def paginate_records(scope)
    setup_pagy(scope)
  end

  private

  # Explicitly delegate pagy setup to ensure argument passing is handled correctly.
  def setup_pagy(scope)
    page_number = fetch_page
    items_count = fetch_per_page
    self.pagy, self.paginated_records = pagy(scope, page: page_number, items: items_count)
  end

  def fetch_page
    context.params&.dig(:page) || 1
  end

  def fetch_per_page
    context.params&.dig(:per_page) || 10
  end
end
