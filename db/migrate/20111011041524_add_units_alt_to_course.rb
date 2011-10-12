class AddUnitsAltToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :units_alt, :string
  end

  def self.down
    remove_column :courses, :units_alt
  end
end
