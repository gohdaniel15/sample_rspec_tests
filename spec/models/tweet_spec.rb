require 'rails_helper'

RSpec.describe User, type: :model do

  subject { create(:tweet) }

  it { is_expected.to belong_to(:user).inverse_of(:tweets) }

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(140) }

end
