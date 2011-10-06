class AddPastInstructorsToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :past_instructors, :string
  end

  def self.down
    remove_column :courses, :past_instructors
  end
end
