class AddCrnToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :crn, :string
  end

  def self.down
    remove_column :courses, :crn
  end
end
