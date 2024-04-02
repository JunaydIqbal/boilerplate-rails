module PermissionAuthenticator
  extend ActiveSupport::Concern

  # for super-admin, if needed to implement specific functionality only for super-admin will use this
  # def authenticate_super_admin!
  #   raise execution_error(message: "Access Denied!") unless context[:current_user].is_a?(Users::SuperAdmin)
  # end

  def authenticate_admin!
    raise execution_error(message: "Access Denied!") unless ([Users::Admin, Users::SuperAdmin].include? context[:current_user].class)
  end

  def authenticate_assessor!
    raise execution_error(message: "Access Denied!") unless context[:current_user].is_a?(Users::Assessor)
  end

  def authenticate_client!
    raise execution_error(message: "Access Denied!") unless context[:current_user].is_a?(Users::Client)
  end
end