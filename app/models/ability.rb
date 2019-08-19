class Ability
  include CanCan::Ability

  def initialize(user)
    cannot :manage, :all

    user ||= User.new
    
    alias_action :create, :read, :update,    to: :cru  
    alias_action :create, :update, :destroy, to: :cud
    alias_action :read, :update,             to: :ru

    if user.present?
      can :ru, :user
    end

    case user.role
    when 'admin'
      can :manage, :all
    when 'doctor'
      can :read, ActiveAdmin::Page, name: 'Dashboard'
      can :ru, Appointment, doctor_id: user.id
      can :ru, User, id: user.id
    when 'patient' 
      can :read, ActiveAdmin::Page, name: 'Dashboard'
      can :ru, User, id: user.id
      can :ru, Appointment, patient_id: user.id
    end

    cannot :destroy, user # user cannot destroy self
  end
end
