class RemoveDescripFromCourse < ActiveRecord::Migration
  def self.up
    remove_column :courses, :descrip
  end

  def self.down
    add_column :courses, :descrip, :text
  end
end
