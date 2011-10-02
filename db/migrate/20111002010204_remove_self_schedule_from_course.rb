class RemoveSelfScheduleFromCourse < ActiveRecord::Migration
  def self.up
    remove_column :courses, :self_schedule
  end

  def self.down
    add_column :courses, :self_schedule, :boolean
  end
end
