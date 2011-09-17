class Search < ActiveRecord::Base
  attr_accessible :name, :day, :units, :instructor
  
  def courses
    @courses ||= find_courses
  end 
  
  private 
  
    def find_courses
      Course.find(:all, :conditions => conditions)
    end 
  
    def name_conditions
      ["courses.name LIKE ?", "%#{name}%"] unless name.blank?
    end
  
    def instructor_conditions
      ["courses.instructor LIKE ?", "%#{instructor}%"] unless instructor.blank?
    end  
  
    def day_conditions
      ["courses.day LIKE ?", "%#{day}%"] unless day.blank?
    end
      
    def unit_conditions
      ["courses.units LIKE ?", "%#{units}%"] unless units.blank?
    end

    def conditions
      [conditions_clauses.join(' AND '), *conditions_options]
    end

    def conditions_clauses
      conditions_parts.map { |condition| condition.first }
    end

    def conditions_options
      conditions_parts.map { |condition| condition[1..-1] }.flatten
    end

    def conditions_parts
      private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
    end
  
end
