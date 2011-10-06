class LineItem < ActiveRecord::Base
  belongs_to :course
  belongs_to :cart 
  validates :course_id, :uniqueness => {:scope => :cart_id}
end
