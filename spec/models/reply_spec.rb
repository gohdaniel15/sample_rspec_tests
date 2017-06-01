require 'rails_helper'

RSpec.describe Reply, type: :model do

  subject { create(:reply) }

  it { is_expected.to belong_to(:user).inverse_of(:replies) }
  it { is_expected.to belong_to(:tweet).inverse_of(:replies) }

  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_most(140) }

end
