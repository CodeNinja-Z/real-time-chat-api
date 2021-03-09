require "rails_helper"

RSpec.describe "Channels API", type: :request do
  let!(:user) { create(:user) }
  let(:headers) { { 'Authorization' => token_generator(user.id) } }
  let(:invalid_headers) { { 'Authorization' => nil } }
  let(:page){ 1 }
  let(:per_page){ 10 }

  # == Endpoints ============================================================

  describe "index | get /api/v1/channels" do
    let!(:channels) { create_list(:channel, 2) }

    context 'when auth token is passed' do
      before { get '/api/v1/channels', headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns all available channels to a user' do
        channels.each do |channel|
          user.channels << channel
        end

        expect(json).to eq(
          Channel.to_payload(user.channels, page, per_page, "joined"=>false)
        )
      end
    end

    context 'when auth token is not passed' do
      before { get '/api/v1/channels', headers: invalid_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "show | get /api/v1/channels/:id" do
    let!(:channel) { create(:channel) }
    
    context 'when auth token is passed' do
      before do
        create_list(:message, 3, channel: channel, user: user)
        
        get("/api/v1/channels/#{channel.id}", headers: headers)
      end 
      
      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end
      
      it "returns the channel's messages with the same order" do
        expect(json).to eq(channel.to_payload(page, per_page))
      end
    end

    context 'when auth token is not passed' do
      before { get "/api/v1/channels/#{channel.id}", headers: invalid_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
