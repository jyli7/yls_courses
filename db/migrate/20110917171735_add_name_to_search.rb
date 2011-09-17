class AddNameToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :name, :string
  end

  def self.down
    remove_column :searches, :name
  end
end
