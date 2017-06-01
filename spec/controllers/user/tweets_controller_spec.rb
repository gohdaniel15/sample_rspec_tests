require 'rails_helper'

RSpec.describe User::TweetsController, type: :controller do

  context 'when not signed in as user' do

    it { expect(get(:index)).to redirect_to(new_user_session_path) }
    it { expect(post(:create)).to redirect_to(new_user_session_path) }
    it { expect(get(:show, id: 1)).to redirect_to(new_user_session_path) }
    it { expect(delete(:destroy, id: 1)).to redirect_to(new_user_session_path) }

  end

  context 'when signed in as user' do

    let(:user) { create(:user) }

    before { sign_in user }

    describe '#index' do

      let!(:tweets) { create_list(:tweet, 3, user: user) }

      before { get :index }

      it { expect(assigns(:tweet)).to have_attributes(user_id: user.id) }
      it { expect(assigns(:tweets)).to eq(tweets) }

    end

    describe '#create' do

      let(:params) { attributes_for(:tweet) }

      before { post :create, tweet: params }

      it { expect(assigns(:tweet)).to have_attributes(user_id: user.id) }

      context 'when params are valid' do

        let(:params) { attributes_for(:tweet) }

        it { is_expected.to redirect_to user_tweets_path }
        it { is_expected.to set_flash[:success] }

      end

      context 'when params are invalid' do

        let(:params) { attributes_for(:tweet, :invalid) }

        it { is_expected.to render_template(:index) }

      end

    end

    describe '#show' do

      let(:tweet) { create(:tweet) }

      before { get :show, id: tweet }

      it { expect(assigns(:tweet)).to eq(tweet) }
      it { expect(response).to render_template :show }

    end

    describe '#destroy' do

      let(:tweet) { create(:tweet) }

      before { delete :destroy, id: tweet.id }

      it { expect(Tweet.count).to eq(0) }
      it { is_expected.to redirect_to user_tweets_path }
      it { is_expected.to set_flash[:success] }

    end

  end

end
