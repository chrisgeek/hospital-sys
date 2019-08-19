require 'rails_helper'

# Test suite for user model
RSpec.describe User, type: :model do
  describe 'Association' do
    it { is_expected.to have_many :appointments }
  end

  describe 'Validations' do
    context 'with basic validation' do
      subject { build(:user) }

      it { is_expected.to validate_inclusion_of(:role).in_array User::VALID_ROLES}
      it { is_expected.to validate_presence_of(:role) }
      it { is_expected.not_to allow_value('invalid email').for(:email) }
      it { is_expected.to validate_presence_of(:name) }
    end
  end

  describe '#to_s' do
    subject(:user) { build(:user) }

    it { expect(user.to_s).to eq(user.name) }
  end
  
  describe '#sends reset password mail' do
    it { expect { create(:user) }.to change(Devise.mailer.deliveries, :count).by(1) }
  end
  
  describe '#role' do
    it { expect(build(:user).role?('admin')).to             be_truthy }
    it { expect(build(:user, :doctor).role?('doctor')).to   be_truthy }
    it { expect(build(:user, :patient).role?('patient')).to be_truthy }
  end


end
