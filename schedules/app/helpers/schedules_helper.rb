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

  def generate_fullcalender_events(sections)
    sections.map do |s|
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
