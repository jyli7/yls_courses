class AddLimitationsToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :limitations, :string
  end

  def self.down
    remove_column :courses, :limitations
  end
end
