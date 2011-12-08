class AddRatingsAuthorizedToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :ratings_authorized, :boolean
  end

  def self.down
    remove_column :users, :ratings_authorized
  end
end
