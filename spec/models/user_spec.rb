require 'rails_helper'

RSpec.describe User, type: :model do

  subject { create(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:contact) }
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }

  it { is_expected.to have_many(:tweets).inverse_of(:user) }
  
end
