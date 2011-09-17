class RemoveKeywordFromSearch < ActiveRecord::Migration
  def self.up
    remove_column :searches, :keyword
  end

  def self.down
    add_column :searches, :keyword, :string
  end
end
