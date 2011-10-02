class AddPaperTypeToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :paper_type, :string
  end

  def self.down
    remove_column :courses, :paper_type
  end
end
