class RemoveSelfScheduledFromCourse < ActiveRecord::Migration
  def self.up
    remove_column :courses, :self_scheduled
  end

  def self.down
    add_column :courses, :self_scheduled, :boolean
  end
end
