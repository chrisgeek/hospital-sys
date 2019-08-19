require 'rails_helper'
require 'cancan/matchers'

describe Ability do
  subject(:ability) { described_class.new(user) } 

  shared_examples_for 'admin restrictions' do
    it { is_expected.not_to be_able_to(:destroy, user) } # user can't delete self
  end

  shared_examples_for 'non admin restrictions' do
    it { is_expected.to be_able_to(:ru, User, id: user.id) }
  end

  context 'when not authenticated' do
    let(:user) { nil }
    
    it { is_expected.not_to be_able_to(:manage, :all) }
  end

  context 'when admin' do
    let(:user) { create(:user) }

    it { is_expected.to be_able_to(:manage, :all) }
  end

  context 'when doctor' do
    let(:user) { create(:user, :doctor) }

    it { is_expected.to be_able_to(:ru, Appointment, doctor_id: user.id) }

    it_behaves_like 'admin restrictions'
    it_behaves_like 'non admin restrictions'
  end

  context 'when patient' do
    let(:user) { create(:user, :patient) }
    
    it { is_expected.to be_able_to(:ru, Appointment, patient_id: user.id) }
    
    it_behaves_like 'non admin restrictions'
    it_behaves_like 'admin restrictions'
  end
end
