class AddInCartToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :in_cart, :boolean, :default => false 
  end

  def self.down
    remove_column :courses, :in_cart
  end
end
