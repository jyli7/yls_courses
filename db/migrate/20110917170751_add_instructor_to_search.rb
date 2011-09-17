class AddInstructorToSearch < ActiveRecord::Migration
  def self.up
    add_column :searches, :instructor, :string
  end

  def self.down
    remove_column :searches, :instructor
  end
end
