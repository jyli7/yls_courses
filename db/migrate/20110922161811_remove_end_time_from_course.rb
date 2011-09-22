class RemoveEndTimeFromCourse < ActiveRecord::Migration
  def self.up
    remove_column :courses, :end_time
  end

  def self.down
    add_column :courses, :end_time, :datetime
  end
end
