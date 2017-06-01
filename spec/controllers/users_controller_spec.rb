require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe '#show' do

    let(:user) { create(:user) }

    before { get :show, id: user.id }

    it { expect(assigns(:user)).to eq(user) }
    it { expect(response).to render_template :show }

  end

end
