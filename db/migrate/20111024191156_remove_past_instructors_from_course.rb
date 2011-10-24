class RemovePastInstructorsFromCourse < ActiveRecord::Migration
  def self.up
    remove_column :courses, :past_instructors
  end

  def self.down
    add_column :courses, :past_instructors, :string
  end
end
