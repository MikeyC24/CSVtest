require 'csv'



	unique_ids_backedup_tasks ={}

CSV.foreach("livecsv/Task.csv" ) do |row|
	
		values = row[1]
		tasks_id = {
			values => nil
		}
		unique_ids_backedup_tasks.merge!(tasks_id)
end

 unique_ids_backedup_tasks_array = unique_ids_backedup_tasks.keys


 CSV.foreach("livecsv/contactinsf.csv" ) do |row|
 	sfid = row[0]
 	if unique_ids_backedup_tasks_array.include?( sfid)
 		unique_ids_backedup_tasks_array.delete( sfid) 
 	end
end
rows = []
CSV.foreach("livecsv/Contact.csv" ) do |row|
	if unique_ids_backedup_tasks_array.include?( row[0])
		 rows << row
	end
end

File.open("livecsv/out.csv", "w") {|f| f.write(rows.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}


=begin
## Methods
# a tester takes indexes numbers stored in an array prints the contents of another array at those indexes 
def loop_array_of_indexes(array, index_array) 
counter = 0
	until counter == index_array.length
		p array[index_array[counter]]
		counter += 1
	end	
end

#use to make a method to search the headers of a large csv for certain words then return the index of those columns
headers = CSV.open("livecsv/hassg.csv", 'r') { |csv| csv.first.map(&:downcase) }

# returns the index of the headers with indicated string
desired_headers_index = headers.each_with_index.select {|header, index| header.include?("selling_agreement")}.map {|pair| pair[1]}.map(&:to_i)

=end