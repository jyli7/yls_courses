class IMDB
  require 'rubygems'
  require 'hpricot'
  require 'open-uri'

  def initialize(url)
    @url = url;
    @hp = Hpricot(open(@url))
  end
  
  def descrip
     @descrip = @hp.at("/html/body/table[2]/tbody/tr[2]/td/table/tbody/tr[4]/td")
  end

  imdb = IMDB.new('http://ylsinfo.law.yale.edu/wsw/prereg/CourseDetails.asp?cClschedid=109684')
  
  puts imdb.descrip
  
end 
