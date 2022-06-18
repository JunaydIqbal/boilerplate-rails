require 'rails_helper'
require './spec/support/shared/authenticable_user'

RSpec.describe GraphqlController, type: :request do
  it_behaves_like 'AuthenticableUser'
end