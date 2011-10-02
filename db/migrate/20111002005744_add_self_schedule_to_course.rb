class AddSelfScheduleToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :self_schedule, :boolean
  end

  def self.down
    remove_column :courses, :self_schedule
  end
end
