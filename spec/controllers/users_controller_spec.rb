require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do

  # == Routes ===============================================================

  context 'routes' do
    it { should route(:post, '/api/v1/signup').to(controller: 'api/v1/users', action: :create) }
  end
end