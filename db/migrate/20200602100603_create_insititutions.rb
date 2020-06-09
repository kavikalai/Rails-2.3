class CreateInsititutions < ActiveRecord::Migration
  def self.up
    create_table :insititutions do |t|
      t.string :file_path
      t.string :insititution_name
      t.timestamps
    end
  end

  def self.down
     drop_table :insititutions
  end
end
