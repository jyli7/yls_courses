class AddWorkloadToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :workload, :float
  end

  def self.down
    remove_column :courses, :workload
  end
end
