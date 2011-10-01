file = File.new("course_data/Spring2011.html")
text = file.readlines
text = text.join('\n')

match = /\(([0-9]+), ([0-9]+)\)">Access to Knowledge Practicum/.match text
puts match, match[0], match[1], match[2]
