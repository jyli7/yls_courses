desc "Get description of each class"
task :get_descrip => :environment do 
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  for course in Course.all
    url = course.address
    doc = Nokogiri::HTML(open(url))
    new_descrip = doc.at_css("tr:nth-child(4) td").text
    course.update_attribute :descrip, new_descrip
  end 
  
  file = File.new("course_data/Spring2011.html")
  text = file.readlines
  text = text.join('\n')
  
  match = /\(([0-9]+), ([0-9]+)\)">Access to Knowledge Practicum/.match text
  

end 
