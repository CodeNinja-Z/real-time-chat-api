require 'rails_helper'

RSpec.describe Message, type: :model do

  # == Relationships ========================================================

  context 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:channel) }
  end

  # == Validations ==========================================================

  context 'validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:channel_id) }
    it { should validate_presence_of(:content) }
  end

  # == FactoryBot ===========================================================

  context 'can be created' do
    it 'with FactoryBot' do
      expect(create(:message)).to be_valid
    end
  end
end
