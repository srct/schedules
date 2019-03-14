require 'json'

ratings = JSON.parse(File.read('db/data/sm18.json'))
semester = Semester.find_by!(season: 'Summer', year: "2018")

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
