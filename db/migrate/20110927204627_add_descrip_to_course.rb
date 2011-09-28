class AddDescripToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :descrip, :string
  end

  def self.down
    remove_column :courses, :descrip
  end
end
