require 'rails_helper'

RSpec.describe Reaction, type: :model do

  subject { create(:reaction) }

  it { is_expected.to belong_to(:user).inverse_of(:reactions) }
  it { is_expected.to belong_to(:tweet).inverse_of(:reactions) }

end
