require 'rails_helper'

RSpec.describe UserChannel, type: :model do

  # == Relationships ========================================================

  context 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:channel) }
  end
  
  # == Validations ==========================================================

  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:channel_id) }
  end

  # == FactoryBot ===========================================================

  context 'can be created' do
    it 'with FactoryBot' do
      expect(create(:user_channel)).to be_valid
    end
  end
end
