require_relative 'excel_loader'

# Deletes all records from the database.
Closure.delete_all
CourseSection.delete_all
Course.delete_all
Semester.delete_all
  
loader = ExcelLoader.new 'db/data/fall2018.xlsx'
         
loader.load_data


