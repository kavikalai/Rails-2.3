class AddAvatarPathToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :avatar_path, :string
  end

  def self.down
    remove_column :users, :avatar_path
  end
end
