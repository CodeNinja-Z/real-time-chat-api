require "rails_helper"

RSpec.describe "Channels API", type: :request do
  let!(:user) { create(:user) }
  let!(:channel) { create(:channel) }
  let(:headers) { { 'Authorization' => token_generator(user.id) } }
  let(:invalid_headers) { { 'Authorization' => nil } }

  # == Endpoints ============================================================

  describe "create | post /api/v1/user_channels" do

    context 'when auth token is passed' do
      before { post "/api/v1/user_channels", 
        params: { user_id: user.id, channel_id: channel.id }, 
        headers: headers }
      
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
      
      it 'returns all available channels to a user' do
        user_channel = UserChannel.create(
          user_id: user.id, channel_id: channel.id, joined_at: DateTime.now)

        expect(json["user_id"]).to eq(user_channel.user_id)
        expect(json["channel_id"]).to eq(user_channel.channel_id)
      end
    end

    context 'when auth token is not passed' do
      before { post "/api/v1/user_channels", 
        params: { user_id: user.id, channel_id: channel.id }, 
        headers: invalid_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
