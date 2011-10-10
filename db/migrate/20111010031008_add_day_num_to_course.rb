class AddDayNumToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :day_num, :integer
  end

  def self.down
    remove_column :courses, :day_num
  end
end
