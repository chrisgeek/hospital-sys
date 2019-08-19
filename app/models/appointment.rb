class Appointment < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :doctor, class_name: 'User'
  belongs_to :patient, class_name: 'User'
  
  scope :doctor, -> { where('user.role == doctor') }
  scope :patient, -> { where('user.role == patient') }
  
  validates :title,   presence: true
end
