require 'rails_helper'

RSpec.describe Channel, type: :model do

  # == Relationships ========================================================

  context 'relationships' do
    it { should have_many(:messages) }
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
    describe 'self.to_payload' do
      let!(:user) { create(:user) }
      let!(:channels) { create_list(:channel, 3) }

      it "returns 3 available channels" do
        channels.each do |channel|
          user.channels << channel
        end

        joined_channels = described_class.to_payload(
          user.channels, 1, 10, joined: true
        )

        unjoined_public_channels = Channel.to_payload(
          user.unjoined_public_channels, 1, 10, joined: false 
        )

        expect(joined_channels.concat(unjoined_public_channels).size).to eq(3)
      end
    end
  end
  
  # == Instance Methods =====================================================

  context 'instance methods' do
    describe 'to_payload' do
      let!(:user) { create(:user) }
      let!(:channel) { create(:channel) }
      let!(:messages) { create_list(:message, 3, channel: channel, user: user) }

      it "returns 3 messages" do
        messages = channel.to_payload(1, 10)
        expect(messages.size).to eq(3)
      end
    end
  end

  describe 'as_json(options: {})' do
    let!(:channel) { create(:channel) }

    it "returns serialized hash" do
      serialized_channel = channel.as_json
      expect(serialized_channel).to have_key("id")
      expect(serialized_channel).to have_key("name")
      expect(serialized_channel).to have_key("is_public")
    end
  end 
end
