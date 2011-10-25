class AddEnrollmentToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :enrollment, :string
  end

  def self.down
    remove_column :courses, :enrollment
  end
end
