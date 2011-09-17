class CreateCourses < ActiveRecord::Migration
  def self.up
    create_table :courses do |t|
      t.string :name
      t.string :number
      t.string :instructor
      t.string :room
      t.string :day
      t.string :units
      t.string :time

      t.timestamps
    end
  end

  def self.down
    drop_table :courses
  end
end
