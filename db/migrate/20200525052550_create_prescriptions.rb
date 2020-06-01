class CreatePrescriptions < ActiveRecord::Migration
  def self.up
    create_table :prescriptions do |t|
      t.integer :appointment_id
      t.string :tests_recommended
      t.string :medicines_prescribed
      t.string :comments
      t.string :followup_schedule
      t.timestamps
    end
  end

  def self.down
    drop_table :prescriptions
  end
end
