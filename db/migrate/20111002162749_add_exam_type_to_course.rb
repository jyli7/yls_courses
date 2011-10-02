class AddExamTypeToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :exam_type, :string
  end

  def self.down
    remove_column :courses, :exam_type
  end
end
