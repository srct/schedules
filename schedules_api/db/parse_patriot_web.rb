# frozen_string_literal: true

require 'thwait'
require 'httparty'
require 'nokogiri'
require 'json'

#
#     USAGE:
#
#     Just run it and it dynamically dumps the latest semester. There's a bit to do it for all of the ones in history commented out below but it'll thrash your RAM and probably piss off PatriotWeb. Also note this script could be trivially modified to correlate human readable names to semester IDs since they're just the .text attribute of the option node.
#
#     There's a few minor issues like multiple spaces in teacher names and we could be scraping out email addresses but no major ones.
#
#     DISCLAIMER/WARNING:
#
#     This opens a number of connections pretty transparently from a script to PatriotWeb. I am not liable if you run this a million times and somehow kill over PatriotWeb. It's a scraper, not a DoS utility.
#

# Credit stackoverflow
class String
  def alpha?
    !!match(/^[[:alpha:]]+$/)
  end
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

def get_crn(title, code, section)
  puts "TODO #{title} #{code} #{section}"
end

def full_major(major)
  resp = HTTParty.post('https://patriotweb.gmu.edu/pls/prod/bwckschd.p_get_crse_unsec',
                       body: "term_in=201870&sel_subj=dummy&sel_day=dummy&sel_schd=dummy&sel_insm=dummy&sel_camp=dummy&sel_levl=dummy&sel_sess=dummy&sel_instr=dummy&sel_ptrm=dummy&sel_attr=dummy&sel_subj=#{major}&sel_crse=&sel_title=&sel_schd=%25&sel_from_cred=&sel_to_cred=&sel_camp=%25&sel_levl=%25&sel_ptrm=%25&sel_instr=%25&begin_hh=0&begin_mi=0&begin_ap=x&end_hh=0&end_mi=0&end_ap=x",
                       headers: {
                         'Content-Type' => 'application/x-www-form-urlencoded',
                         'charset' => 'utf-8'
                       })
  searcher = Nokogiri::HTML(resp)
  data = feed_course_info(searcher)
end

def initialize_req(subj, num)
  base_url = 'https://patriotweb.gmu.edu/pls/prod/bwckctlg.p_disp_listcrse?term_in=201870'
  stub = "subj_in=#{subj}&crse_in=#{num}&schd_in=%25"
  resp = HTTParty.get("#{base_url}&#{stub}")
  searcher = Nokogiri::HTML(resp)
  data = feed_course_info(searcher)
end

def getSemesters
  semesters = []
  resp = HTTParty.get('https://patriotweb.gmu.edu/pls/prod/bwckschd.p_disp_dyn_sched')
  searcher = Nokogiri::HTML(resp)
  searcher.css('option').each do |opt|
    if opt.attr('value').start_with? '20'
      semesters.push(opt.attr('value'))
    end
  end
  semesters
end

def getCourses(semester)
  semesters = []
  resp = HTTParty.post('https://patriotweb.gmu.edu/pls/prod/bwckgens.p_proc_term_date',
                       body: "p_calling_proc=bwckschd.p_disp_dyn_sched&p_term=#{semester}&p_by_date=Y&p_from_date=&p_to_date=",
                       headers: {
                         'Content-Type' => 'application/x-www-form-urlencoded',
                         'charset' => 'utf-8'
                       })
  searcher = Nokogiri::HTML(resp)
  #  puts searcher.inspect
  searcher.xpath('//*[@id="subj_id"]/option').each do |opt|
    if opt.attr('value').strip.alpha?
      semesters.push(opt.attr('value'))
    end
  end
  semesters
end

# end


# total.each { |subject|
#   puts subject.first
#   subject[1].each { |section|
#     puts section
#   }
# }

def load_data
  # Initialize threads to be waited on array
  threads = []

  total = {}
  # below will get you literally all semesters which is wildly overkill
  # getSemesters.each do |semester|
  semester = getSemesters.first
  getCourses(semester).each do |course|
    threads << Thread.new {
      total[course] = full_major(course)
    }
  end

  ThreadsWait.all_waits(*threads)

  Semester.delete_all
  Course.delete_all
  Section.delete_all

  semester = Semester.create! season: 'Fall', year: '2018'
  semester.save!

  total.each { |subject|
    subject[1].each { |crn|
      section = crn[1]
      course = Course.find_or_create_by(subject: section[:subj],
                                        course_number: section[:code])

      course.semester = semester
      course.save!

      section_name = "#{section[:subj]} #{section[:code]} #{section[:sect]}"
      Section.create!(name: section_name,
                      crn: section[:crn],
                      title: section[:name],
                      course: course)

      puts "#{section[:subj]} #{section[:code]} #{section[:sect]} #{section[:name]}"
    }
  }
end
