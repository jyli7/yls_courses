class RemovePastSemestersFromCourse < ActiveRecord::Migration
  def self.up
    remove_column :courses, :past_semesters
  end

  def self.down
    add_column :courses, :past_semesters, :string
  end
end
