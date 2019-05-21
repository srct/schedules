module Update
  FILE_NAME = "db/data/last_update.txt".freeze

  def self.last_update_date
    begin
      File.open(FILE_NAME).first
    rescue
      "Data has not yet been loaded."
    end
  end

  def self.new_update
    File.write(FILE_NAME, Time.now.strftime("%Y-%m-%d %k:%M:%S"))
  end
end
