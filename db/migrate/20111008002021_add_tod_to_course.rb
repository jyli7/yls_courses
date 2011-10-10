class AddTodToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :tod, :string
  end

  def self.down
    remove_column :courses, :tod
  end
end
