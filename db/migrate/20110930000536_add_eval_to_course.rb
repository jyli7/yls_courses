class AddEvalToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :eval, :string
  end

  def self.down
    remove_column :courses, :eval
  end
end
