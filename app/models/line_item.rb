class LineItem < ActiveRecord::Base
  belongs_to :course
  belongs_to :cart 
  validates :course_id, :uniqueness => {:scope => :cart_id}
  attr_accessor :in_cart
  
  after_create :update_parent_in_cart
    
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
  
  private 
  
    def update_parent_in_cart
      self.course.update_attribute :in_cart, self.in_cart
    end 
end
