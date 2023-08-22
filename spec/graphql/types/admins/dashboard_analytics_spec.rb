require 'rails_helper'

RSpec.describe Types::Admins::DashboardAnalytics do
  context "Fields" do
    it "should respond to all fields with correct types" do
      expect(described_class.fields).to include("newUsersCount")
      expect(described_class.fields).to include("usersCount")
      expect(described_class.fields).to include("activeUsersCount")
      expect(described_class.fields).to include("revokedUsersCount")

      new_users_count_field = described_class.fields["newUsersCount"]
      users_count_field = described_class.fields["usersCount"]
      active_users_count_field = described_class.fields["activeUsersCount"]
      revoked_users_count_field = described_class.fields["revokedUsersCount"]

      expect(new_users_count_field.type.of_type).to eq(GraphQL::Types::Int)
      expect(new_users_count_field.type.class).to eq(GraphQL::Schema::NonNull)

      expect(users_count_field.type).to eq(GraphQL::Types::Int)
      expect(users_count_field.type.class).to eq(GraphQL::Schema::NonNull)

      expect(active_users_count_field.type).to eq(GraphQL::Types::Int)
      expect(active_users_count_field.type.class).to eq(GraphQL::Schema::NonNull)

      expect(revoked_users_count_field.type).to eq(GraphQL::Types::Int)
      expect(revoked_users_count_field.type.class).to eq(GraphQL::Schema::NonNull)
    end
  end
end
