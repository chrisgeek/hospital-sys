RSpec.describe Appointment, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:user).optional }
    it { is_expected.not_to belong_to :doctor }
    it { is_expected.to belong_to :patient }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:title) }
  end
end
