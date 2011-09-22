class AddStartTimeToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :start_time, :string
  end

  def self.down
    remove_column :courses, :start_time
  end
end
