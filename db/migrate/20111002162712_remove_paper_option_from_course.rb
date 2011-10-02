class RemovePaperOptionFromCourse < ActiveRecord::Migration
  def self.up
    remove_column :courses, :paper_option
  end

  def self.down
    add_column :courses, :paper_option, :boolean
  end
end
