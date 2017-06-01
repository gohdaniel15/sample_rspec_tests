require 'rails_helper'

RSpec.describe TweetsController, type: :controller do

  describe '#show' do

    let(:user) { create(:user) }
    let(:tweet) { create(:tweet) }

    context 'when signed in as user' do

      before { sign_in user }

      it { expect(get(:show, user_id: user, id: tweet)).to redirect_to(user_tweet_path(id:tweet)) }

    end

    context 'when not signed in as user' do

      before { get :show, user_id: user, id: tweet }

      it { expect(assigns(:tweet)).to eq(tweet) }
      it { expect(response).to render_template :show }

    end

  end

end
