ActiveAdmin.register Appointment do

  permit_params :title, :patient_id, :doctor_id, :date, :user_id, :status
  # permit_params do
  #   permitted = [:permitted, :attributes]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
     
  index do
    selectable_column
    id_column
    column :patient
    column :doctor unless current_user.doctor?
    column :title
    column :date
    column :status
    actions
  end

  form do |f|
    doctors = User.where(role: 'doctor')
    patients = User.where(role: 'patient')
    status_options = %w[Pending Postponed Seen]
    f.inputs do
      f.input :title
      f.input :patient, collection: patients,   prompt: 'Select Patient', include_blank: false
      f.input :doctor,  collection: doctors,    prompt: 'Select Doctor',  include_blank: false
      f.input :date
      f.input :status, collection: status_options, prompt: 'Update Status', include_blank: false unless f.object.new_record? 
    end
    f.actions
  end

end
