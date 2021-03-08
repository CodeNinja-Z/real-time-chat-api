require "rails_helper"

RSpec.describe User, type: :model do

  # == Relationships ========================================================

  context 'relationships' do
    it { should have_many(:messages) }
    it { should have_many(:channels).through(:user_channels) }
  end

  # == Validations ==========================================================

  context 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:password) }
    it { should validate_confirmation_of(:password) }

    it { should have_secure_password }

    it { should validate_uniqueness_of(:email) }
    it { should validate_uniqueness_of(:username) }

    it { should validate_length_of(:email).is_at_least(2) }
    it { should validate_length_of(:email).is_at_most(254) }
    it { should validate_length_of(:username).is_at_least(2) }
    it { should validate_length_of(:username).is_at_most(40) }
    it { should validate_length_of(:password).is_at_least(4) }
  end

  # == FactoryBot ===========================================================

  context 'can be created' do
    it 'with FactoryBot' do
      expect(create(:user)).to be_valid
    end
  end

  # == Instance Methods =====================================================

  context 'instance methods' do
    describe 'unjoined_public_channels' do
      let!(:user) { create(:user) }
      let!(:channels) { create_list(:channel, 3) }

      it "returns 3 messages" do
        user.channels << channels.first
        res_channels = user.unjoined_public_channels
        expect(res_channels.size).to eq(2)
      end
    end
  end
end
