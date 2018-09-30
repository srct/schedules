module SearchHelper
  class GenericItem
    def initialize(type, data)
      @type = type
      @data = data
    end
    
    def self.fetchall(query_string)
      models = []
      models += fetch_instructors query_string
      models += fetch_courses query_string
      build_list(models)
    end
    
    def self.fetch_instructors(query_string)
      Instructor.from_name(Instructor.select("*"), query_string).all
    end
    
    def self.fetch_courses(query_string)
      query_string.upcase!
      CourseReplacementHelper.replace!(query_string)
      base_query = Course.select("courses.*, count(course_sections.id) AS section_count")
                         .left_outer_joins(:course_sections)
                         .having("section_count > 0")
                         .group("courses.id")
  
      subj = nil
      query_string.scan(/(?<= |^)([a-zA-Z]{2,4})(?=$| )/).each do |a|
        s = a[0]
        if get_count(Course.from_subject(base_query, s)).positive?
          subj = s
          base_query = Course.from_subject(base_query, subj)
          query_string.remove!(s)
        end
      end
   
      query_string.scan(/(?<= |^)(\d{3})(?=$| )/).each do |a|
        s = a[0]
        next unless !subj.nil? && get_count(Course.from_course_number(base_query, s)).positive?
        base_query = Course.from_course_number(base_query, s)
                           .order("courses.course_number ASC")
        return base_query.all
      end
      
      base_query = Course.from_title(base_query, query_string.gsub(/ +/, " ").strip)
                         .order("section_count DESC")
        
      base_query.all
    end
      
    
    # Given a set of models, create a list of GenericItems for each model's data
    def self.build_list(models)
      list = []
      models.each do |model|
        list.push(GenericItem.new(model.class.name.underscore, model))
      end
      
      list
    end
    
    def self.get_count(base_query)
      # I think I finally hit a limit of active record
      ActiveRecord::Base.connection.execute("SELECT COUNT(*) AS count FROM (#{base_query.to_sql})")[0]["count"]
    end
    
    def to_s()
      @type
    end
  end
end
