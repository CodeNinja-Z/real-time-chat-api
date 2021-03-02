require 'rails_helper'

RSpec.describe Channel, type: :model do

  # == Relationships ========================================================

  context 'relationships' do
    it { should have_many(:users).through(:user_channels) }
  end

  # == Validations ==========================================================

  context 'validations' do
    it { should validate_presence_of(:name) }

    it { should validate_uniqueness_of(:name) }

    it { should validate_length_of(:name).is_at_least(4) }
    it { should validate_length_of(:name).is_at_most(40) }
  end

  # == FactoryBot ===========================================================

  context 'can be created' do
    it 'with FactoryBot' do
      expect(create(:channel)).to be_valid
    end
  end

  # == Class Methods =====================================================

  context 'class methods' do
    describe 'self.available_to_user(user)' do
      it "returns 3 available channels" do
        create_list(:channel, 3)
        all_available_channels = described_class.available_to_user(User.first)
        expect(all_available_channels.size).to eq(3)
      end
    end
  end
end
