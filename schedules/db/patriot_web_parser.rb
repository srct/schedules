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
    def parse_courses_in_subject(semester, subject)
      response = @networker.fetch_courses_in_subject(semester, subject)
      document = Nokogiri::HTML(response)
      get_courses(document, subject)
    end

    private

    # Parse the values of all different options on the Patriot Web
    # semester select page
    # @param document [Nokogiri::HTML::Document]
    def get_semesters_from_option_values(document)
      document.css('option').map do |opt| # for each option value
        next unless opt.attr('value').start_with? '20' # ensure it is a semester value
        text = opt.text.gsub(/ *\(.*\).*/, "").gsub(/ +/, " ")
        season, year = text.split
        { value: opt.attr('value'), season: season, year: year }
      end
    end

    # Parse all subject codes from the select element on the Patriot Web
    # subject select page
    # @param document [Nokogiri::HTML::Document]
    def get_subject_codes_from_option_values(document)
      document.xpath('//*[@id="subj_id"]/option').map do |opt| # for each option value under "subj_id"
          opt.attr('value') if opt.attr('value').strip.alpha? # return the value if the value is alphanumeric
      end
    end

    # Parse all courses from the subject search page
    # @param document [Nokogiri::HTML::Document]
    # @return [Array] courses
    def get_courses(document, _subject)
      table = document.css('html body div.pagebodydiv table.datadisplaytable')
      rows = table.css('tr')
      data_from rows
    end

    # Extract data about all course sections from the rows
    def data_from(rows)
      i = 0
      result = []

      while i < rows.length
        if title?(rows[i].text) # check if the row is a title
          data = {}

          title_elements = rows[i].text.split(' - ')
          data[:title] = title_elements[0].strip
          data[:crn] = title_elements[1]
          full_name = title_elements[2].split(' ')
          next unless full_name.length == 2
          data[:subj] = full_name[0]
          data[:course_number] = full_name[1]
          data[:section] = title_elements[3].strip

          details = rows[i + 2].css('td table tr td')
          if details.empty?
            # puts "#{full_name.join(' ')} is fake news"
            i += 1
            next
          end

          times = details[1].text.split(' - ')
          if times.length == 1
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

          # Get rid of extra spaces and parentheses at the end of prof. names
          data[:instructor] = details[6].text.gsub(/ *\(.*\).*/, "").gsub(/ +/, " ")

          result << data
          i += 5 # skip to what we think is the next title
        else
          i += 1 # try the next row if this one was not a title
        end
      end

      result
    end

    # a title looks this: Survey of Accounting - 71117 - ACCT 203 - 001
    def title?(text)
      elements = text.split(' - ')
      elements.length == 4 && elements[2].split(' ').length == 2
    end
  end
end
