class AddEndTimeToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :end_time, :string
  end

  def self.down
    remove_column :courses, :end_time
  end
end
