class CoursesController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  # GET /courses
  # GET /courses.xml
  def index
    @search = Course.search(params[:search])

    #for creating line items in the cart
    if user_signed_in?
      @user = current_user
      @cart = @user.cart
      
      if @cart
        @line_item = @cart.line_items.build(params[:line_item])
        @line_items_in_cart = @cart.line_items.all
        @courses_in_cart = @line_items_in_cart.inject({}) do |h, line_item|
          h[line_item.course] = true
          h
        end        
      end
    end

    #present all courses, or just present courses in cart
    if params[:filter_by_cart] == "1"
      @courses = @search.order("name asc").all & @cart.line_items.all.map {|line_item| line_item.course}
    else 
      @courses = @search.order("name asc").all
    end 
                
    #toggle 0 corresponds to information view, 1 for ratings view
    if params[:toggle] == "0" or params[:toggle] == "1"
      @toggle = params[:toggle]
    else 
      @toggle = "0"
    end
          
    #form an array of course names for the autocomplete function
    @course_names = Course.all.map {|a| a.name}
    @instructor_names = Course.all.map {|a| a.instructor}
    @instructor_names.uniq!
    
    #for retaining search results
    @tod_results = params[:search] == nil ? :blank : params[:search][:tod_like]
    @units_results = params[:search] == nil ? :blank : params[:search][:units_like]
    @limitations_results = params[:search] == nil ? :blank : params[:search][:limitations_like]
    @exam_results = params[:search] == nil ? :blank : params[:search][:exam_type_like]
    @paper_results = params[:search] == nil ? :blank : params[:search][:paper_type_like]
        
    #everything that follows is for the calendar
    if params[:cal_on] == "1" #'1' is for calendar view --> triggers a different part of index.js.erb
      @cal_on = 1
    else 
      @cal_on = 0
    end 
    
    if @cal_on == 1
      @info = {} #hash structure is {:name => [[days], [start_hour, start_segment], class_length, time, room]}
      unless @line_items_in_cart.blank? #if there are no line items, don't show a calendar 
        #cycle through the line items
        @line_items_in_cart.each do |item|
          unless item.course.day.blank? #some courses are clinics and don't meet at a time. don't try to show these. 
            name = item.course.name
            days = item.course.day 
            time = item.course.time
            id = item.course.id
            room = item.course.room unless item.course.room.blank?
            room = "No room" if item.course.room.blank?
            
            @info[name] = [] #for the array value for the name key
                
            if days.include? "h" #if one day is Thursday ("Th")
              if days.length == 2
                @info[name] << ["Th"]
              else 
                @info[name] << ["#{days[0]}", "Th"]
              end 
            else
              if days.length >= 2              
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
            @info[name] << times_array
            @info[name] << [room]
          end
        end 
      end 
      
      #create a single array, composed of smaller arrays, that feeds into the view 
      #Examples of component arrays: [Admin, M4, 11, 1, SLB], [Antitrust, T2, 11, 1, SLB]
      @result_array = []
      @info.each_key do |key|
        count = 0 #just to keep track of which day we're on
        #loop through each day in the first sub-array of the @info[key] array
        @info[key][0].each do |day|
          temp_array = []
          #add course_name to temp_array
          temp_array << key
          if @info[key].length == 5 and count == 1 #if we're on the second day, and the days have different times
            temp_array << day + @info[key][2][0] # e.g. M4
            temp_array << @info[key][2][2] # e.g. 11
            temp_array << @info[key][2][1] # e.g. 1
            temp_array << @info[key][3][1] # e.g. "3:10p - 5:00p"
            temp_array << @info[key][4][0] # e.g. "SLB"
          else
            temp_array << day + @info[key][1][0] # e.g. M4
            temp_array << @info[key][1][2] # e.g. 11
            temp_array << @info[key][1][1] # e.g. 1
            if @info[key].length == 5 and count == 0 #if we're on the first day, and the days have different times
              temp_array << @info[key][3][0] # e.g. "3:10p - 5:00p"
              temp_array << @info[key][4][0] # e.g. "SLB"
            else #if the days do not have different times
              temp_array << @info[key][2][0] # e.g. "3:10p - 5:00p"
              temp_array << @info[key][3][0] # e.g. "SLB"
            end
          end
          @result_array << temp_array
          count += 1
        end 
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.js
      format.xml  { render :xml => @courses }
    end
  end

  # GET /courses/1
  # GET /courses/1.xml
  def show
    @course = Course.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/new
  # GET /courses/new.xml
  def new
    @course = Course.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @course }
    end
  end

  # GET /courses/1/edit
  def edit
    @course = Course.find(params[:id])
  end

  # POST /courses
  # POST /courses.xml
  def create
    @course = Course.new(params[:course])

    respond_to do |format|
      if @course.save
        format.html { redirect_to(@course, :notice => 'Course was successfully created.') }
        format.xml  { render :xml => @course, :status => :created, :location => @course }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courses/1
  # PUT /courses/1.xml
  def update
    @course = Course.find(params[:id])

    respond_to do |format|
      if @course.update_attributes(params[:course])
        format.html { redirect_to(@course, :notice => 'Course was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @course.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.xml
  def destroy
    @course = Course.find(params[:id])
    @course.destroy

    respond_to do |format|
      format.html { redirect_to(courses_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def sort_column
    Course.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
  
end
