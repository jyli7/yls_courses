class AddPaperOptionToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :paper_option, :boolean
  end

  def self.down
    remove_column :courses, :paper_option
  end
end
