class PagesController < ApplicationController
  def about
    @title = "About"
  end
  
  def faq
    @faq = "About"
  end
  
  def cal
    @line_items = LineItem.all
    @info = {} #hash structure is {:name => [[days], [start_hour, start_segment] class_length]}
    unless @line_items.blank? #if there are no line items, don't show a calendar 
      #cycle through the line items
      @line_items.each do |item| 
        unless item.course.day.blank? #some courses are clinics and don't meet at a time. don't try to show these. 
          name = item.course.name
          days = item.course.day 
          time = item.course.time
          id = item.course.id
          
          @info[name] = [] #for the array value for the name key
                  
          if days.include? "h" #if one day is Thursday ("Th")
            if days.length == 2
              @info[name] << ["Th"]
            elsif days[0..1] == "TT"
              @info[name] << ["T", "Th"]
            elsif days[-1] == "F"
              @info[name] << ["Th", "F"]  
            end 
          else
            if days.length == 2
              @info[name] << [days[0], days[1]] #if class does not meet on Thursday, but meets twice a week
            else 
              @info[name] << [days] #if class meets just once a week
            end
          end  
          
          def time_values(time) #returns an arrray with start hour, start minutes (segments past the hour), length
            hours_array = ['8','9','10','11','12','1','2','3','4','5','6','7','8']

            #find the difference between the hours 
            start_hour = time[0...time.index(":")]
            finish_hour = time[(time.index("-")+1)...time.index(":", 3)]
            #find the distance between the finish hour and the start hour *within the hours array*
            if start_hour == '6' and finish_hour == '8' #account for the fact that there are two "8s" in the array. 
              #each "segment" is 10 minutes
              segments = ((hours_array.length-1) - hours_array.index(start_hour))*6 #this ensures that we index the second 8
            else
              segments = (hours_array.index(finish_hour) - hours_array.index(start_hour))*6
            end

            #then subtract intervals from the starting hour (e.g. the :10 from 3:10)
            start_segments = time[time.index(":")+1].to_i
            segments = segments - start_segments #subtract a segment for each segment past the hour

            #then add intervals to the ending hour (e.g. the :30 in -7:30)
            finish_segments = time[time.index(":", 3)+1].to_i
            segments = segments + finish_segments 
            return [start_hour, start_segments, segments] 
          end             
          
          if time.include? "," #if there are two different times for two days
            times_array = time.split(", ")
          else 
            times_array = [time] #if there's just 1 time (for one or more days) 
          end 
          times_array.each do |t|
            @info[name] << time_values(t)
          end
        end
      end 
    end
    
    #create a single array, composed of smaller arrays, that feeds into the view 
    #Examples of component arrays: [Admin, M4, 11, 1], [Antitrust, T2, 11, 1]
    @result_array = []
    @info.each_key do |key|
      count = 0 #just to keep track of which day we're on
      @info[key][0].each do |day|
        temp_array = []
        temp_array << key
        if @info[key].length == 3 and count == 1 #if we're on the second day, and the days have different times
          temp_array << day + @info[key][2][0] # e.g. M4
          temp_array << @info[key][2][2] # e.g. 11
          temp_array << @info[key][2][1] # e.g. 1
        else
          temp_array << day + @info[key][1][0] # e.g. M4
          temp_array << @info[key][1][2] # e.g. 11
          temp_array << @info[key][1][1] # e.g. 1
        end
        @result_array << temp_array
        count += 1
      end 
    end 
          
    respond_to do |format|
      format.html #cal.html.erb
      format.js #cal.js.erb
      format.xml  { render :xml => @courses }
    end            
  end
  
  
end
