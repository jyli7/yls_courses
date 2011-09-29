class ChangeDataTypeForCourseDescrip < ActiveRecord::Migration
  def self.up
    change_table :courses do |t|
      t.change :descrip, :text
    end 
  end

  def self.down
  end
end