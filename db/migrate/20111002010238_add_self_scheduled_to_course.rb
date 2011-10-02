class AddSelfScheduledToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :self_scheduled, :boolean
  end

  def self.down
    remove_column :courses, :self_scheduled
  end
end
