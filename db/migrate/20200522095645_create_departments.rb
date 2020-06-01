class CreateDepartments < ActiveRecord::Migration
  def self.up
    create_table :departments do |t|
      t.string :name
      t.boolean :status
      t.integer :created_by
      t.timestamps
    end
  end

  def self.down
    drop_table :departments
  end
end
