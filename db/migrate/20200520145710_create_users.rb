class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :user_name
      t.string :email
      t.string :encrypted_password
      t.string :encrypted_password_iv
      t.string :contact_no
      t.string :address
      t.string :type
      t.integer :department_id
      t.boolean :status
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
