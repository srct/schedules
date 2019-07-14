require 'httparty'
require 'nokogiri'

sem = ARGV.first

# bamboozle website
headers = {
  'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:65.0) Gecko/20100101 Firefox/65.0',
  'Accept': 'text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8',
  'Accept-Encoding': 'gzip, deflate, br',
  # 'Referer': 'https://crserating.gmu.edu/ReportPaper/',
  'Content-Type': 'application/x-www-form-urlencoded',
  'Connection': 'keep-alive',
  'Cookie': 'ga=GA1.2.1878572417.1543773996; __unam=74bec77-167701a5090-6fe3a784-10; __insp_slim=1549744302281; CFID=1938650; CFTOKEN=b1990d0cd24bb3f4-19FA09EB-5056-9470-35EEF241BAFA23D5; CFGLOBALS=urltoken%3DCFID%23%3D1938650%26CFTOKEN%23%3Db1990d0cd24bb3f4%2D19FA09EB%2D5056%2D9470%2D35EEF241BAFA23D5%23lastvisit%3D%7Bts%20%272019%2D01%2D29%2019%3A40%3A10%27%7D%23timecreated%3D%7Bts%20%272019%2D01%2D29%2019%3A39%3A51%27%7D%23hitcount%3D7%23cftoken%3Db1990d0cd24bb3f4%2D19FA09EB%2D5056%2D9470%2D35EEF241BAFA23D5%23cfid%3D1938650%23; __insp_wid=1435896333; __insp_nv=true; __insp_ref=aHR0cHM6Ly9pcnIyLmdtdS5lZHUvTmV3L05fRW5yb2xsT2ZmL0VucmxTdHMuY2Zt; __insp_targlpu=https%3A%2F%2Firr2.gmu.edu%2FNew%2FN_EnrollOff%2FEnrlSts.cfm; __insp_targlpt=Office%20of%20Institutional%20Research%20and%20Effectiveness; BIGipServer~web.gmu.edu~goose.gmu.edu_p80=1242087434.20480.0000',
  'Upgrade-Insecure-Requests': '1',
  'Cache-Control': 'max-age=0'
}

resp = HTTParty.post('https://crserating.gmu.edu/ReportPaper/InstructorList.cfm',
                     body: "SearchType=instructor&semester=#{sem}&ctitle=&iname=&divsname=&deptname=&disc=&ckey=&orig=off&SearchTypeHid=instructor",
                     headers: headers).body

document = Nokogiri::HTML(resp)

values = document.css('select option').map { |e| e['value'] }
i = values.index('--Select an Instructor--')
values = values[i + 1..-1]
all = {}
c = values.count
counter = 1
values.each do |v|
  puts "#{counter}/#{c} getting data for #{v}..."
  counter += 1
  resp = HTTParty.post('https://crserating.gmu.edu/ReportPaper/InstructorList.cfm',
                       body: "SearchType=instructor&semester=#{sem}&ctitle=&iname=#{v}&divsname=&deptname=&disc=&ckey=&orig=off&SearchTypeHid=instructor",
                       headers: headers)

  document = Nokogiri::HTML(resp)

  rows = document.css('tr')
  i = rows.index { |r| r.css('td').first&.text == 'Course' }
  next if i.nil?
  rows[i + 1..-3].each do |s_tr|
    tds = s_tr.css('td')

    id = tds.first.css('font a').first['href'].match(/[0-9]+/)[0]
    section, instr = tds.first&.text, tds[2]&.text

    resp = HTTParty.post("https://crserating.gmu.edu/ReportPaper/MeansSummary16.cfm?rat_num=#{id}&caller=InstructorList",
                         body: "semester=#{sem}&formseq=62&orig=off&iname=#{instr}",
                         headers: headers)
    document = Nokogiri::HTML(resp)

    rows = document.css('tr')
    qs = (9..39).to_a.select(&:odd?).map do |n|
      datas = rows[n].css('td')
      { q: datas[0].text.match(/[A-Z].*/)[0], resp: datas[1].text.strip, instr_mean: datas[2].text.strip, dept_mean: datas[3].text.strip }
    end
    all[section] = qs
  end
  puts '------------------------------'
end

File.write("db/data/#{sem}.json", all.to_json)
