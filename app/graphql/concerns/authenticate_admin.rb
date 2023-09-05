module AuthenticateAdmin
  extend ActiveSupport::Concern

  def authenticate_admin!
    raise execution_error(message: "Access Denied!") unless context[:current_user].admin?
  end
end