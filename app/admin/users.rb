ActiveAdmin.register User do
  permit_params :email, :password, :password_confirmation, :role, :name

  index do
    selectable_column
    id_column
    column :email
    column :name
    column :role
    column :created_at
    actions
  end

  filter :email
  filter :name
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    @roles = %w[admin doctor patient]
    f.inputs do
      f.input :name
      f.input :email
      f.input :role,   collection: @roles,   prompt: 'Select Role', include_blank: false
    end
    f.actions
  end
end
