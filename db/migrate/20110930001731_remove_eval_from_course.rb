class RemoveEvalFromCourse < ActiveRecord::Migration
  def self.up
    remove_column :courses, :eval
  end

  def self.down
    add_column :courses, :eval, :string
  end
end
