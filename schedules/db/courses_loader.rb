require 'nokogiri'
require 'httparty'
require 'thwait'
require_relative 'patriot_web_parser'

def nbsp
  [160].pack('U*')
end

def get_courses(subj)
  response = HTTParty.get("https://catalog.gmu.edu/courses/#{subj}")
  document = Nokogiri::HTML(response)

  course_blocks = document.css('.courseblock')
  course_blocks.map do |course|
    full_title = course.css('.courseblocktitle').first.text
    subj, num = full_title.split(': ').first.split(nbsp)
    next if subj.nil?

    name, credits_full = full_title.split(': ')[1..-1].join(': ').split('. ')
    credits_num = credits_full.split.first

    description = course.css('.courseblockdesc').text

    {
      subject: subj,
      title: name,
      course_number: num,
      credits: credits_num,
      description: description
    }
  end
end
