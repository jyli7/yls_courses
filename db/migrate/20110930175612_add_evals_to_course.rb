class AddEvalsToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :evals, :text
  end

  def self.down
    remove_column :courses, :evals
  end
end
