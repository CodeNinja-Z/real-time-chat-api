require "rails_helper"

RSpec.describe "Channels API", type: :request do
  let!(:user) { create(:user) }
  let(:headers) { { 'Authorization' => token_generator(user.id) } }
  let(:invalid_headers) { { 'Authorization' => nil } }

  # == Endpoints ============================================================

  describe "index | get /api/v1/channels" do
    let!(:channels) { create_list(:channel, 2) }
    let(:first_channel) { channels[0] }
    let(:second_channel) { channels[1] }

    context 'when auth token is passed' do
      before { get '/api/v1/channels', headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns all available channels to a user' do
        res_channels = response_body

        expect(res_channels[0]["id"]).to eq(first_channel.id)
        expect(res_channels[0]["name"]).to eq(first_channel.name)
        expect(res_channels[0]["is_public"]).to eq(first_channel.is_public)

        expect(res_channels[1]["id"]).to eq(second_channel.id)
        expect(res_channels[1]["name"]).to eq(second_channel.name)
        expect(res_channels[1]["is_public"]).to eq(second_channel.is_public)
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
    let(:messages) { channel.messages }
    let(:first_message) { messages[0] }
    let(:second_message) { messages[1] }
    let(:third_message) { messages[2] }

    context 'when auth token is passed' do
      before { get "/api/v1/channels/#{channel.id}", headers: headers }

      it 'returns status code 200' do
        expect(response).to have_http_status(:success)
      end

      it 'returns all available channels to a user' do
        expect(response_body[2]["message_id"]).to eq(third_message.id)
        expect(response_body[2]["username"]).to eq(third_message.user.username)
        expect(response_body[2]["channel_name"]).to eq(channel.name)
        expect(response_body[2]["content"]).to eq(third_message.content)

        expect(response_body[1]["message_id"]).to eq(second_message.id)
        expect(response_body[1]["username"]).to eq(second_message.user.username)
        expect(response_body[1]["channel_name"]).to eq(channel.name)
        expect(response_body[1]["content"]).to eq(second_message.content)

        expect(response_body[0]["message_id"]).to eq(first_message.id)
        expect(response_body[0]["username"]).to eq(first_message.user.username)
        expect(response_body[0]["channel_name"]).to eq(channel.name)
        expect(response_body[0]["content"]).to eq(first_message.content)
      end
    end

    context 'when auth token is not passed' do
      before { get "/api/v1/channels/#{channel.id}", headers: invalid_headers }

      it 'returns status code 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  def response_body
    JSON.parse(response.body)
  end
end
