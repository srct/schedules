module SearchHelper
  class GenericItem
    def initialize(type, data)
      @type = type
      @data = data
    end
    
    def self.fetchall(query_string)
      models = []
      models.push(fetch_instructors query_string)
      models.push(fetch_courses query_string)
      build_list(models)
    end
    
    def self.fetch_instructors(query_string)
      Instructor.from_name(Instructor.select("*"), query_string).all
    end
    
    def self.fetch_courses(query_string)
      query_string.upcase!
      CourseReplacementHelper.replace!(query_string)
      base_query = Course.select("*")
  
      subj = nil
      query_string.scan(/(?<= |^)([a-zA-Z]{2,4})(?=$| )/).each do |a|
        s = a[0]
        if Course.from_subject(select("*"), s).count.positive?
          subj = s
          base_query = Course.from_subject(base_query, subj)
          query_string.remove!(s)
        end
      end
   
      query_string.scan(/(?<= |^)(\d{3})(?=$| )/).each do |a|
        s = a[0]
        next unless !subj.nil? && from_course_number(from_subject(select("*"), subj), s).count.positive?
        base_query = Course.from_course_number(s)
        return base_query.all
      end
      
      base_query = Course.from_title(query_string.gsub(/ +/, " ").strip)
      base_query.all
    end
      
    
    # Given a set of models, create a list of GenericItems for each model's data
    def self.build_list(models)
      list = []
      models.each do |model|
        list.push(GenericItem.new(model.name, model))
      end
      
      list
    end
  end
end
