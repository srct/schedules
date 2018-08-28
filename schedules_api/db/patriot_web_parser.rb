require_relative 'patriot_web_networker'
require 'nokogiri'

class String
  # Checks if a String is a alphanumeric
  def alpha?
    !!match(/^[[:alpha:]]+$/)
  end
end

module PatriotWeb
  # Contains methods for parsing data retrieved from Patriot Web
  class Parser
    def initialize
      @networker = PatriotWeb::Networker.new
    end
    
    # Parses all semesters avaliable on Patriot Web
    def parse_semesters
      response = @networker.fetch_page_containing_semester_data 
      document = Nokogiri::HTML(response) # parse the document from the HTTP response

      get_semesters_from_option_values(document).compact
    end

    # Parses subjects belonging to a given semester id
    # @param semester_id [Integer]
    def parse_subjects(semester_id)
      response = @networker.fetch_subjects(semester_id)
      document = Nokogiri::HTML(response)
      get_subject_codes_from_option_values(document)
    end

    # Parses all courses belonging to a given subject
    # @param subject [String]
    def parse_courses_in_subject(subject)
      response = @networker.fetch_courses_in_subject(subject)
      document = Nokogiri::HTML(response)
      get_courses(document)
    end

    private
    
    # Parse the values of all different options on the Patriot Web
    # semester select page
    # @param document [Nokogiri::HTML::Document]
    def get_semesters_from_option_values(document)
      document.css('option').map do |opt| # for each option value
        if opt.attr('value').start_with? '20' # ensure it is a semester value
          opt.attr('value') # return the value
        end
      end
    end

    # Parse all subject codes from the select element on the Patriot Web
    # subject select page
    # @param document [Nokogiri::HTML::Document]
    def get_subject_codes_from_option_values(document)
      document.xpath('//*[@id="subj_id"]/option').map do |opt| # for each option value under "subj_id"
        if opt.attr('value').strip.alpha? # if the value is alphanumeric
          opt.attr('value') # return the value
        end
      end
    end

    # Parse all courses from the subject search page 
    # @param document [Nokogiri::HTML::Document]
    # @return [Array] courses
    def get_courses(document)
      table = document.css('html body div.pagebodydiv table.datadisplaytable')
      rows = table.css('tr')

      (0..(rows.length/6-1)).map do |i|
        start = i*5
        data = {}
        title = rows[start].text
        # the title looks this: Survey of Accounting - 71117 - ACCT 203 - 001
        # so split it by ' - ' and extract
        title_elements = title.split(' - ')
        next unless title_elements.length == 4
        data[:title] = title_elements[0].strip
        data[:crn] = title_elements[1]
        
        full_name = title_elements[2].split(' ')
        next unless full_name.length == 2
        data[:subj] = title_elements[2].split(' ')[0]
        data[:course_number] = title_elements[2].split(' ')[1]
        
        data[:section] = title_elements[3].strip

        # rows 1 to 3 contain info about registration and drop dates.
        # for now we're gonna ignore them and skip to row 4, which contains details
        details = rows[start+2].css('td table tr td')

        next unless details.length > 0 # if there are no details, skip this item
        # details = detail_rows.last.text.split("\n").compact.reject(&:empty?) # skip empty strings
        
        times = details[1].text.split(' - ')
        if (times.length == 1)
          data[:start_time] = 'TBA'
          data[:end_time] = 'TBA'
        else
          data[:start_time] = times[0]
          data[:end_time] = times[1]
        end

        data[:days] = details[2].text.strip
        data[:location] = details[3].text.strip
        
        dates = details[4].text.split(' - ')
        data[:start_date] = dates[0]
        data[:end_date] = dates[1]
        
        data[:type] = details[5].text
        data[:instructor] = details[6].text
        data
      end
      # puts rows[0].text
      # puts rows[2].css('td table tr td')
      # puts rows[5].text
      # puts rows[7].css('td table tr td')
      
      # puts rows[10].text
      # puts rows[12].css('td table tr td')
      # (0..(rows.length/3-1)).each do |i|
      #   start = i*3
        
      #   puts rows[start].search('th').first.text
      #   section_data = rows[start+2].css('td table.datadisplaytable').search('td')
      #   puts section_data[1].text
      # end
      # puts rows[3]
      # puts rows[3].search('th').first.text
      # section_data = rows[5].css('td table.datadisplaytable').search('td')
      # puts section_data[1].text

      # end
      # each section is represented by 6 rows in the table
      # (0..(rows.length/6 - 1)).map do |i|
      #   start = i*6
      #   data = {}
      #   title = rows[start].text
      #   # the title looks this: Survey of Accounting - 71117 - ACCT 203 - 001
      #   # so split it by ' - ' and extract
      #   title_elements = title.split(' - ')
      #   next unless title_elements.length == 4
      #   data[:title] = title_elements[0].strip
      #   data[:crn] = title_elements[1]
        
      #   full_name = title_elements[2].split(' ')
      #   next unless full_name.length == 2
      #   data[:subj] = title_elements[2].split(' ')[0]
      #   data[:course_number] = title_elements[2].split(' ')[1]
        
      #   data[:section] = title_elements[3].strip

      #   # rows 1 to 3 contain info about registration and drop dates.
      #   # for now we're gonna ignore them and skip to row 4, which contains details
      #   detail_rows = rows[start+4].css('tr')
      #   next unless detail_rows.length > 0 # if there are no details, skip this item
      #   details = detail_rows.last.text.split("\n").compact.reject(&:empty?) # skip empty strings
        
      #   times = details[1].split(' - ')
      #   if (times.length == 1)
      #     data[:start_time] = 'TBA'
      #     data[:end_time] = 'TBA'
      #   else
      #     data[:start_time] = times[0]
      #     data[:end_time] = times[1]
      #   end

      #   data[:days] = details[2].strip
      #   data[:location] = details[3].strip
        
      #   dates = details[4].split(' - ')
      #   data[:start_date] = dates[0]
      #   data[:end_date] = dates[1]
        
      #   data[:type] = details[5]
      #   data[:instructor] = details[6]
      #   data
      # end
    end
  end
end
