require 'csv'

accountids_hassg = []
CSV.foreach("livecsv/hassg.csv") do |row|
	accountids_hassg << row[0]	
end

unique_ids_backedup_has_sg_array = []
CSV.foreach("livecsv/Contact.csv") do |row|
	contactid = row[3]
	if accountids_hassg.include?(contactid)
		sfidsg = row[0]
		unique_ids_backedup_has_sg_array <<	sfidsg	
	end
end
 
CSV.foreach("livecsv/contactinsf.csv" ) do |row|
 	sfid = row[0]
 	if unique_ids_backedup_has_sg_array.include?( sfid)
 		unique_ids_backedup_has_sg_array.delete( sfid) 
 	end
end

CSV.foreach("livecsv/oldidsandnewids.csv" ) do |row|
 	oldid = row[1]
 	if unique_ids_backedup_has_sg_array.include?( oldid)
 		unique_ids_backedup_has_sg_array.delete( oldid) 
 	end
end

rows = []
CSV.foreach("livecsv/Contact.csv" ) do |row|
	if unique_ids_backedup_has_sg_array.include?( row[0])
		 rows << row
	end
end

File.open("livecsv/out.csv", "w") {|f| f.write(rows.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}
