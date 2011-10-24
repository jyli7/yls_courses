class AddClasstimeValueToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :classtime_value, :float
  end

  def self.down
    remove_column :courses, :classtime_value
  end
end
