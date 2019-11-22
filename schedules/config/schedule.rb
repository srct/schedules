set :output, "cron_log.log"

every 1.day, at: '3:00 am' do
    command 'rails runner db/seeds.rb update'
end
