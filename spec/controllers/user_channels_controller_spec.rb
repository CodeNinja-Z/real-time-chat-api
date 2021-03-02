require "rails_helper"

RSpec.describe Api::V1::UserChannelsController, type: :controller do

  # == Routes ===============================================================
  
  context 'routes' do
    it { should route(:post, '/api/v1/user_channels').to(action: :create) }
  end
end
