require 'rails_helper'

RSpec.describe "Searches", type: :request do
  let!(:user) { create(:user) }
  let!(:channel) { create(:channel) }
  let(:headers) { { 'Authorization' => token_generator(user.id) } }
  let(:invalid_headers) { { 'Authorization' => nil } }

  # == Endpoints ============================================================

  describe "query | post /api/v1/search" do    
    context 'when auth token is passed' do
      before do 
        user.update(username: 'Andrew G')
        channel.update(name: 'Tom and Jerry')

        post "/api/v1/search", params: { search_input: 'and' }, headers: headers
      end
      
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
      
      it 'returns the correct user and channel search results' do
        expect(json["users"].first).to eq(user.as_json)
        expect(json["channels"].first).to eq(channel.as_json)
      end
    end

    context 'when auth token is not passed' do
      before { post "/api/v1/search", 
        params: { search_input: 'and' }, headers: invalid_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
