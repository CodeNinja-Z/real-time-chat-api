require "rails_helper"

RSpec.describe Api::V1::ChannelsController, type: :controller do

  # == Routes ===============================================================

  context 'routes' do
    it { should route(:get, '/api/v1/channels').to(action: :index) }
    it { should route(:get, '/api/v1/channels/1').to(action: :show, id: 1) }
  end
end
