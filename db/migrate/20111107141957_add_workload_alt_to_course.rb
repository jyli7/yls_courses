class AddWorkloadAltToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :workload_alt, :float
  end

  def self.down
    remove_column :courses, :workload_alt
  end
end
