ActiveAdmin.register Appointment do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :title, :patient_id, :doctor_id, :date, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  form do |f|
    doctors = User.where(role: 'doctor')
    patients = User.where(role: 'patient')
    f.inputs do
      f.input :title
      f.input :patient, collection: patients,   prompt: 'Select Patient', include_blank: false
      f.input :doctor,  collection: doctors,   prompt: 'Select Doctor', include_blank: false
      f.input :date
    end
    f.actions
  end

end
