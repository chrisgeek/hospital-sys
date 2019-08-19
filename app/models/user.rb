class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable,
         :rememberable, :validatable
  
  VALID_ROLES = %w[admin doctor patient]
  has_many :appointments
  
  auto_strip_attributes :name, squish: true

  after_create :send_reset_password_instructions

  validates :email, presence: true
  validates :role,  presence: true
  validates :role,  inclusion: { in: VALID_ROLES } 
  validates :name,  presence: true

  VALID_ROLES.each do |method|
    define_method "#{method}?" do
      role? method
    end
  end
  
  def role?(role_title)
    role == role_title.to_s
  end

  def to_s
    name 
  end
end
