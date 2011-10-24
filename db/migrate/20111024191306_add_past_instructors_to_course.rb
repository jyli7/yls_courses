class AddPastInstructorsToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :past_instructors, :text
  end

  def self.down
    remove_column :courses, :past_instructors
  end
end
