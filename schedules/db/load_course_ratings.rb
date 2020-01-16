require 'json'

seasons = { "f" => "Fall", "sp" => "Spring", "sm" => "Summer" }
begin
  sems = File.readlines('db/data/sems_loaded.txt').map do |line|
    line.strip
  end
rescue StandardError
  sems = []
  File.new('db/data/sems_loaded.txt', 'w')
end

f = File.open('db/data/sems_loaded.txt', 'a')
(Dir.entries("db/data").select { |f| f.end_with? ".json" }).each do |file|
  /(?<season>[[:alpha:]]{1,2})(?<year>[0-9]{2})/.match(file) do |m|
    if sems.include? m.to_s
      puts "already found #{file}"
      next
    end
    season = seasons[m[:season]]
    year = "20#{m[:year]}"
    semester = Semester.find_by(season: season, year: year)
    next if semester.nil?

    begin
      ratings = JSON.parse(File.read("db/data/#{file}"))
    rescue StandardError
      next
    end

    puts "Loading #{season} #{year} ratings..."
    ratings.each do |section, qs|
      begin
        section = section.split(',').first
        subj = section.match(/[A-Z]+/)[0]
        course = section.match(/[0-9]{3} /)[0].strip
        sect_num = section.match(/ [A-Z0-9]+/)[0].strip
        next if subj.nil? || course.nil? || sect_num.nil?
        name = "#{subj} #{course} #{sect_num}"
        s = CourseSection.find_by(name: name, semester: semester)
        next if s.nil?
        s.rating_questions = qs
        s.save!
      rescue StandardError
        puts "error on #{section}"
        next
      end
    end
  end
end
