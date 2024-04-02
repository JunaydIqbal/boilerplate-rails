module PermissionAuthenticator
  extend ActiveSupport::Concern

  def authenticate_super_admin!
    raise execution_error(message: "Access Denied!") unless context[:current_user].is_a?(Users::SuperAdmin)
  end

  def authenticate_admin!
    raise execution_error(message: "Access Denied!") unless context[:current_user].is_a?(Users::Admin)
  end

  def authenticate_assessor!
    raise execution_error(message: "Access Denied!") unless context[:current_user].is_a?(Users::Assessor)
  end

  def authenticate_client!
    raise execution_error(message: "Access Denied!") unless context[:current_user].is_a?(Users::Client)
  end
end