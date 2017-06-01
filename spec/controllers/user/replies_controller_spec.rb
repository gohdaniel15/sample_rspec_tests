require 'rails_helper'

RSpec.describe User::RepliesController, type: :controller do

  context 'when not signed in as user' do

    it { expect(post(:create, tweet_id: 1)).to redirect_to(new_user_session_path) }
    it { expect(delete(:destroy, tweet_id: 1, id: 1)).to redirect_to(new_user_session_path) }

  end

  context 'when signed in as user' do

  let(:user) { create(:user) }
  let(:tweet) { create(:tweet) }

  before { sign_in user }

    describe '#create' do

      let(:params) { attributes_for(:reply) }

      before { post :create, tweet_id: tweet.id, reply: params }

      it { expect(assigns(:reply)).to have_attributes(user_id: user.id, tweet_id: tweet.id) }

      context 'when params are valid' do

        let(:params) { attributes_for(:reply) }

        it {is_expected.to redirect_to user_tweet_path(id: tweet.id) }
        it {is_expected.to set_flash[:success] }

      end

      context 'when params are invalid' do

        let(:params) { attributes_for(:reply, :invalid) }

        it { is_expected.to render_template('user/tweets/show', id: tweet.id) }

      end

    end

    describe '#destroy' do

      let(:reply) { create(:reply, tweet: tweet) }

      before { delete :destroy, tweet_id: tweet.id, id: reply.id }

      it { expect(Reply.count).to eq(0) }
      it { is_expected.to redirect_to user_tweet_path(id: tweet.id) }
      it { is_expected.to set_flash[:success] }

    end

  end

end
