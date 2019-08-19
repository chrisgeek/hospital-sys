class AddDoctorToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointments, :doctor, index: true
  end
end
