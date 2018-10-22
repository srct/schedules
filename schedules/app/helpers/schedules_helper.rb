module SchedulesHelper
  DAYS = {
    "M": Date.new(2019, 1, 14),
    "T": Date.new(2019, 1, 15),
    "W": Date.new(2019, 1, 16),
    "R": Date.new(2019, 1, 17),
    "F": Date.new(2019, 1, 18),
    "S": Date.new(2019, 1, 19),
    "U": Date.new(2019, 1, 20)
  }.freeze

  def generate_fullcalender_events(id_sets)
    id_sets.map do |id_set|
      id_set.to_a.map do |s|
        s.days.split('').map do |day|
          formatted_date = DAYS[day.to_sym].to_s.tr('-', '')
          time = Time.parse(s.start_time).strftime("%H%M%S")
          endtime = Time.parse(s.end_time).strftime("%H%M%S")

          {
            title: s.name,
            start: "#{formatted_date}T#{time}",
            end: "#{formatted_date}T#{endtime}"
          }
        end
      end.flatten
    end
  end

  def generate_schedules(all_sections)
    recur_build(all_sections, 0, Set.new).flatten!.select do |s|
      s.to_a.size == all_sections.count
    end
  end

  def recur_build(all_sections, i, set)
    num_courses = all_sections.count
    course_sections = all_sections[i]

    course_sections.map do |section|
      new_set = Set.new(set)
      fits = true
      set.to_a.each do |s|
        fits = !section.overlaps?(s)
        break if !fits
      end

      new_set << section if fits

      if i == num_courses - 1
        new_set
      else
        recur_build(all_sections, i + 1, new_set)
      end
    end
  end
end
