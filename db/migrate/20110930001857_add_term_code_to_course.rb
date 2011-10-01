class AddTermCodeToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :term_code, :string
  end

  def self.down
    remove_column :courses, :term_code
  end
end
