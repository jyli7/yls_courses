class RemoveExamFromCourse < ActiveRecord::Migration
  def self.up
    remove_column :courses, :exam
  end

  def self.down
    add_column :courses, :exam, :boolean
  end
end
