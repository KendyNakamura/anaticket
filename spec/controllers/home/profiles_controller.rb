require 'rails_helper'

RSpec.describe Home::ProfilesController, type: :controller do
  let(:user) { create(:user) }

  describe 'GET #show' do
    before do
      login_user user
    end
    it 'renders the :show template' do
      get :show
      expect(response.status).to eq 200
    end
  end
end
