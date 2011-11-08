class AddInstructorQualityAltToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :instructor_quality_alt, :float
  end

  def self.down
    remove_column :courses, :instructor_quality_alt
  end
end
