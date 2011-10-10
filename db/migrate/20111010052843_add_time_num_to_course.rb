class AddTimeNumToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :time_num, :integer
  end

  def self.down
    remove_column :courses, :time_num
  end
end
