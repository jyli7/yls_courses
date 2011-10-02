class AddExamToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :exam, :boolean
  end

  def self.down
    remove_column :courses, :exam
  end
end
