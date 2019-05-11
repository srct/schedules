require 'json'

[['sp18', 'Spring', '2018'], ['sm18', 'Summer', '2018'], ['f18', 'Fall', '2018'],
 ['sp17', 'Spring', '2017'], ['sm17', 'Summer', '2017'], ['f17', 'Fall', '2017'],
 ['sp16', 'Spring', '2016'], ['sm16', 'Summer', '2016'], ['f16', 'Fall', '2016']].each do |arr|
  begin
    ratings = JSON.parse(File.read("db/data/#{arr[0]}.json"))
  rescue StandardError
    next
  end
  semester = Semester.find_by(season: arr[1], year: arr[2])
  next if semester.nil?

  puts "#{ratings[1]} #{ratings[2]}"

  ratings.each do |section, qs|
    section = section.split(',').first
    subj = section.match(/[A-Z]+/)[0]
    course = section.match(/[0-9]{3} /)[0].strip
    sect_num = section.match(/ [A-Z0-9]+/)[0].strip
    name = "#{subj} #{course} #{sect_num}"
    s = CourseSection.find_by(name: name, semester: semester)
    next if s.nil?
    s.rating_questions = qs
    s.save!
  end
end
