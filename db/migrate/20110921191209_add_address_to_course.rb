class AddAddressToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :address, :string
  end

  def self.down
    remove_column :courses, :address
  end
end
