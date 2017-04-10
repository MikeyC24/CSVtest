require 'csv'

oldids_newids = {}
CSV.foreach("livecsv/Oldidswithnewids.csv" ) do |row|
 	oldid = row[1]
 	newid = row[0]
 	oldid_newid = {

 		oldid => newid

 		} 

 	oldids_newids.merge!( oldid_newid)

end

rows = []
CSV.foreach("livecsv/Task.csv" ) do |row|
	contactsoldid = row[1]
	task = []
	task << row
	contactsnewid = oldids_newids[contactsoldid]
	task << contactsnewid
	if contactsnewid != nil
		rows << task

	end
end


File.open("livecsv/out.csv", "w") {|f| f.write(rows.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}