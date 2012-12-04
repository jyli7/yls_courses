class Cart < ActiveRecord::Base
  has_many :line_items, :dependent => :destroy 
  belongs_to :user

  def lower_bound
    sum = 0
    line_items.each do |item| 
      unless item.lower_bound.nil?
        sum += item.lower_bound
      end
    end 
    sum
  end 
  
  def upper_bound
    sum = 0
    line_items.each do |item| 
      unless item.upper_bound.nil?
        sum += item.upper_bound
      end
    end 
    sum
  end

end