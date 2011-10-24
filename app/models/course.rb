class Course < ActiveRecord::Base
  serialize :crn
  serialize :term_code
  serialize :past_instructors
  serialize :past_semesters
  
  has_many :line_items, :dependent => :destroy
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  def self.tod_array
    a = []
    Course.all.each do |course|
      unless a.include? course.tod or course.tod.nil?
        a << course.tod
      end 
    end
    #Just to reorganize the array so that morning comes first and evening comes last
    last = a.pop
    first_two = a.first(2)
    a.slice!(0..1)
    a.push(first_two[0], first_two[1], last)
    return a
  end 
  
  private
    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
      if line_items.empty?
        return true
      else
        errors.add(:base, 'Line Items present')
        return false
      end
    end
    
end
