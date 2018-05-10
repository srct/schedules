require_relative 'patriot_web_networker'
require 'nokogiri'

class String
  def alpha?
    !!match(/^[[:alpha:]]+$/)
  end
end

module PatriotWeb
  class Parser
    def initialize
      @networker = PatriotWeb::Networker.new
    end

    def parse_semesters
      response = @networker.fetch_page_containing_semester_data
      searcher = Nokogiri::HTML(response)

      get_semesters_from_option_values(searcher).compact
    end

    def parse_subjects(semester_id)
      response = @networker.fetch_subjects(semester_id)
      searcher = Nokogiri::HTML(response)

      get_alpha_option_values(searcher)
    end

    def parse_courses_in_subject(subject)
      resp = @networker.fetch_courses_in_subject(subject)
      searcher = Nokogiri::HTML(resp)
      feed_course_info(searcher)
    end

    private

    def get_alpha_option_values(searcher)
      searcher.xpath('//*[@id="subj_id"]/option').map do |opt|
        if opt.attr('value').strip.alpha?
          opt.attr('value')
        end
      end
    end

    def get_semesters_from_option_values(searcher)
      searcher.css('option').map do |opt|
        if opt.attr('value').start_with? '20'
          opt.attr('value')
        end
      end
    end

    def feed_course_info(searcher)
      table = searcher.css('html body div.pagebodydiv table.datadisplaytable')
      data = {}
      currentobj = nil
      table.css('table.datadisplaytable').first.children.each do |row|
        next unless row.name == 'tr'
        row.children.each do |item|
          currentobj = sort_item(item, currentobj, data)
        end
      end
      data
    end

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
