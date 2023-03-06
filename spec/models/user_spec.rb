require 'rails_helper'

RSpec.describe User, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  # Data objects
  let(:user) { build(:user) }

  context 'Columns' do
    it { should have_db_column(:email).of_type(:string) }
    it { should have_db_column(:full_name).of_type(:string) }
    it { should have_db_column(:first_name).of_type(:string) }
    it { should have_db_column(:last_name).of_type(:string) }
    it { should have_db_column(:role).of_type(:integer) }
    it { should define_enum_for(:role) }
  end

  # context 'Associations' do
  #   pending('Add some examples here..')
  # end

  context 'Enums' do
    it 'should have admin and user roles available' do
      expect(described_class.roles).to eq({'admin' => 0, 'user' => 1})
    end

    it 'should have default role as #user' do
      expect(user.role).to eq('user')
    end
  end
end
