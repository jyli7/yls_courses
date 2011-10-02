class AddPaperRequiredToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :paper_required, :boolean
  end

  def self.down
    remove_column :courses, :paper_required
  end
end
