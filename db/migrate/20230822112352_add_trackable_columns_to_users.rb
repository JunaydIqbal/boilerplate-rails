class AddTrackableColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :sign_in_count, :string, default: 0, null: false
    add_column :users, :current_sign_in_at, :datetime
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :current_sign_in_ip, :inet
    add_column :users, :last_sign_in_ip, :inet

    # Add :terms_and_conditions acceptance column inside users table
    add_column :users, :terms_and_conditions, :boolean, default: false
  end
end
