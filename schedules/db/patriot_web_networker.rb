require 'httparty'

module PatriotWeb
  # Contains utilities for making HTTP requests to PatriotWeb
  class Networker
    def fetch_page_containing_semester_data
      HTTParty.get('https://patriotweb.gmu.edu/pls/prod/bwckschd.p_disp_dyn_sched')
    end

    def fetch_subjects(semester_id)
      HTTParty.post('https://patriotweb.gmu.edu/pls/prod/bwckgens.p_proc_term_date',
                    body: "p_calling_proc=bwckschd.p_disp_dyn_sched&p_term=#{semester_id}&p_by_date=Y&p_from_date=&p_to_date=",
                    headers: {
                      'Content-Type' => 'application/x-www-form-urlencoded',
                      'charset' => 'utf-8'
                    })
    end

    def fetch_courses_in_subject(subject)
      HTTParty.post('https://patriotweb.gmu.edu/pls/prod/bwckschd.p_get_crse_unsec',
                    body: "term_in=201870&sel_subj=dummy&sel_day=dummy&sel_schd=dummy&sel_insm=dummy&sel_camp=dummy&sel_levl=dummy&sel_sess=dummy&sel_instr=dummy&sel_ptrm=dummy&sel_attr=dummy&sel_subj=#{subject}&sel_crse=&sel_title=&sel_schd=%25&sel_from_cred=&sel_to_cred=&sel_camp=%25&sel_levl=%25&sel_ptrm=%25&sel_instr=%25&begin_hh=0&begin_mi=0&begin_ap=x&end_hh=0&end_mi=0&end_ap=x",
                    headers: {
                      'Content-Type' => 'application/x-www-form-urlencoded',
                      'charset' => 'utf-8'
                    })
    end
  end
end
