require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "GET #home" do

    it 'returns http success' do
      get :home
      expect(response).to have_http_status(:success)
    end

    context 'when signed in as user' do

      let(:user) { create(:user) }

      before { sign_in user }

      it { expect(get(:home)).to redirect_to(user_tweets_path) }

    end

  end

end
