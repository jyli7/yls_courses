class AddClasstimeValueAltToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :classtime_value_alt, :float
  end

  def self.down
    remove_column :courses, :classtime_value_alt
  end
end
