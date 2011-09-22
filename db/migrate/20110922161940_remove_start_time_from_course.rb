class RemoveStartTimeFromCourse < ActiveRecord::Migration
  def self.up
    remove_column :courses, :start_time
  end

  def self.down
    add_column :courses, :start_time, :datetime
  end
end
