class AddPatientToAppointment < ActiveRecord::Migration[5.2]
  def change
    add_reference :appointments, :patient, index: true
  end
end
