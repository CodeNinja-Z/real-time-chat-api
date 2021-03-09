require "rails_helper"

RSpec.describe Api::V1::SearchController, type: :controller do

  # == Routes ===============================================================

  context 'routes' do
    it { should route(:post, '/api/v1/search').to(action: :query) }
  end
end
