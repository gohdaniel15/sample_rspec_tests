require 'rails_helper'

RSpec.describe RelationshipsController, type: :controller do

  context 'when not signed in as user' do

    it { expect(post(:create, user_id: 1)).to redirect_to(new_user_session_path) }
    it { expect(delete(:destroy, user_id: 1, id: 1)).to redirect_to(new_user_session_path) }

  end

  context 'when signed in as user' do

    let(:user1) { create(:user) }
    let(:user2) { create(:user) }

    before { sign_in user1 }

    describe '#create' do

      before { post :create, user_id: user2.id }

      it { expect(assigns(:relationship)).to have_attributes(follower_id: user1.id, followed_id: user2.id) }
      it { is_expected.to redirect_to root_path }

    end

    describe '#destroy' do

      let(:relationship) { create(:relationship) }

      before { delete :destroy, user_id: user2.id, id: relationship.id }

      it { expect(Relationship.count).to eq(0) }
      it { is_expected.to redirect_to root_path }

    end

  end

end
