class LineItem < ActiveRecord::Base
  belongs_to :course
  belongs_to :cart 
  validates :course_id, :uniqueness => {:scope => :cart_id}
  
  def lower_bound
    unless course.nil?
      course.units[0].to_i
    end 
  end 
  
  def upper_bound
    unless course.nil?
      course.units[-1].to_i
    end 
  end 
end
