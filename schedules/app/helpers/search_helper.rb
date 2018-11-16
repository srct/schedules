module SearchHelper
  def in_cart?(id)
    @cart.include? id.to_s
  end

  class GenericQueryData
    attr_reader :semester
    attr_reader :sort_mode
    attr_reader :search_string

    def initialize(search_string, sort_mode, semester)
      @semester = semester
      @sort_mode = sort_mode
      @search_string = search_string
    end
  end

  class GenericItem
    attr_reader :data
    attr_reader :type

    def initialize(type, data)
      @type = type
      @data = data
    end

    def self.fetchall(search_string, sort_mode: :auto, semester: :fall2018)
      query_data = GenericQueryData.new(search_string, sort_mode, semester)
      models = []
      models += fetch_instructors query_data
      models += fetch_courses query_data
      build_list(models)
    end

    def self.fetch_instructors(query_data)
      Instructor.from_name(Instructor.select("instructors.*, COUNT(courses.id) AS section_count").from("course_sections"), query_data.search_string)
                .joins("LEFT OUTER JOIN instructors ON instructors.id = course_sections.instructor_id")
                .joins("LEFT OUTER JOIN courses ON courses.id = course_sections.course_id AND courses.semester_id = #{query_data.semester.id}")
                .group("instructors.id").all
    end

    def self.fetch_courses(query_data)
      query_string = query_data.search_string
      query_string.upcase!
      CourseReplacementHelper.replace!(query_string)
      base_query = Course.select("courses.*, count(course_sections.id) AS section_count")
                         .left_outer_joins(:course_sections)
                         .having("section_count > 0")
                         .where("courses.semester_id = ?", query_data.semester)
                         .group("courses.id")

      subj = nil
      query_string.scan(/(?<= |^)([a-zA-Z]{2,4})(?=$| )/).each do |a|
        s = a[0]
        next unless get_count(Course.from_subject(base_query, s)).positive?
        subj = s
        base_query = Course.from_subject(base_query, subj)
        query_string.remove!(s)
      end

      query_string.scan(/(?<= |^)(\d{3})(?=$| )/).each do |a|
        s = a[0]
        next unless !subj.nil? && get_count(Course.from_course_number(base_query, s)).positive?
        base_query = Course.from_course_number(base_query, s)
        return base_query.all
      end

      stripped_query_string = query_string.gsub(/ +/, " ").strip

      # There's more to parse
      base_query = if stripped_query_string.length.positive?
                     Course.from_title(base_query, stripped_query_string)
                           .order("section_count DESC")
                   else
                     base_query.order("courses.course_number ASC")
                   end

      base_query.all
    end

    # Given a set of models, create a list of GenericItems for each model's data
    def self.build_list(models)
      list = []
      models.each do |model|
        list.push(GenericItem.new(model.class.name.underscore.to_sym, model))
      end

      list
    end

    def self.get_count(base_query)
      # I think I finally hit a limit of active record
      ActiveRecord::Base.connection.execute("SELECT COUNT(*) AS count FROM (#{base_query.to_sql})")[0]["count"]
    end

    def to_s
      @type
    end
  end
end
