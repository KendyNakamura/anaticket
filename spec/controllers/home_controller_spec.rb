require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:user) { create(:user) }
  describe 'GET #index' do
    context 'ログインしている時' do
      before do
        login_user user
      end

      it 'has a 200 status code' do
        expect(response).to have_http_status(:ok)
      end
      it 'renders the :index template' do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
