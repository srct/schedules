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
      feed_course_info(document)
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

    # TODO write docs
    def feed_course_info(searcher)
      # find the table containing the courses
      table = searcher.css('html body div.pagebodydiv table.datadisplaytable') 
      data = {}
      currentobj = nil
      table.css('table.datadisplaytable').first.children.each do |row| # for each row in the table
        next unless row.name == 'tr' # only search table rows, ignore headers
        row.children.each do |item|
          currentobj = sort_item(item, currentobj, data)
        end
      end
      data
    end

    # TODO break this up and write docs
    def sort_item(item, currentobj, data)
      if item.name == 'th'
        if item.to_html.include? '-'
          titletxt = item.text
          if item.text.include? ' - Honors'
            titletxt = titletxt.gsub(' - Honors', ' (Honors)')
          end
          titledetails = titletxt.split(' - ')
          if titledetails.count > 4
            titledetails = ["#{titledetails[0]} #{titledetails[1]}", titledetails[2], titledetails[3], titledetails[4]]
          end
          titledata = titledetails[2].split(' ')
          begin
            data = get_details(data, titledetails, titledata)[0]
            currentobj = get_details(data, titledetails, titledata)[1]
          rescue StandardError => e
            puts item
            puts e
            exit(1)
          end
          currentobj[:fields] = []
        end
      elsif item.is_a? Nokogiri::XML::Element
        item.css('th').each do |field|
          currentobj[:fields].push(field.text.downcase.tr(' ', '_'))
        end
        iter = 0
        if currentobj
          if currentobj[:fields]
            upper = currentobj[:fields].count - 1
            while iter <= upper
              assign = item.css('td')[iter].text
              currentobj[currentobj[:fields][iter]] = assign
              iter += 1
            end
          end
        end
      end
      currentobj
    end
    
    # TODO break this up and write docs
    def get_details(data, titledetails, titledata)
      crn = titledetails[1].strip
      data[crn] = {} unless data[titledetails[1]]
      crsinfo = { 'name': titledetails[0].strip }
      uniquedata = { 'sect': titledetails[3].strip, 'crn': titledetails[1].strip }
      general = { 'subj': titledata[0].strip, 'code': titledata[1].strip }
      data[crn] = general.merge(uniquedata.merge(crsinfo))
      data[crn][:code] = titledetails[2].split(' ')[1]
      [data, data[crn]]
    end
  end
end
