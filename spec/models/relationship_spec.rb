require 'rails_helper'

RSpec.describe Relationship, type: :model do

  subject { create(:relationship) }

  it { is_expected.to belong_to(:follower) }
  it { is_expected.to belong_to(:followed) }

end
