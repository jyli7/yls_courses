class AddPastSemestersToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :past_semesters, :string
  end

  def self.down
    remove_column :courses, :past_semesters
  end
end
