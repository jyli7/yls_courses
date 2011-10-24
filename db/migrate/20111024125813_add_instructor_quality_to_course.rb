class AddInstructorQualityToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :instructor_quality, :float
  end

  def self.down
    remove_column :courses, :instructor_quality
  end
end
