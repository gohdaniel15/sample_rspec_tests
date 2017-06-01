require 'rails_helper'

RSpec.describe User::ReactionsController, type: :controller do

  context 'when not signed in as user' do

    it { expect(post(:create, tweet_id: 1)).to redirect_to(new_user_session_path) }
    it { expect(delete(:destroy, tweet_id: 1, id: 1)).to redirect_to(new_user_session_path) }

  end

  context 'when signed in as user' do

  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  before { sign_in user }

    describe '#create' do

      before { post :create, tweet_id: tweet.id, format: 'js' }

      it { expect(assigns(:reaction)).to have_attributes(user_id: user.id, tweet_id: tweet.id) }
      it { expect(response).to render_template(partial: '_unlike_button') }

    end

    describe '#destroy' do

      let(:reaction) { create(:reaction, tweet: tweet) }

      before { delete :destroy, tweet_id: tweet.id, id: reaction.id, format: 'js' }

      it { expect(response).to render_template(partial: '_like_button') }
      it { expect(Reaction.count).to eq(0) }

    end

  end

end
