require 'json'

[['f18', 'Fall', '2018'], ['sp18', 'Spring', '2018'],
 ['f17', 'Fall', '2017'], ['sp17', 'Spring', '2017']].each do |arr|
  puts arr
  ratings = JSON.parse(File.read("db/data/#{arr[0]}.json"))
  semester = Semester.find_by!(season: arr[1], year: arr[2])

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
