require 'time'

module Update
  FILE_NAME = "db/data/last_update.txt".freeze

  def self.last_update_date
    if File.exist?(FILE_NAME)
      File.open(FILE_NAME).first
    else
      "Data has not yet been loaded."
    end
  end

  def self.new_update
    File.write(FILE_NAME, Time.now.in_time_zone('America/New_York').strftime("%Y-%m-%d %k:%M:%S"))
  end
end
