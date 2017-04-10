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

CSV.foreach("livecsv/Contact.csv" ) do |row|
	contactsoldid = row[0]
	contactinfo = []
	contactinfo << row
	contactsnewid = oldids_newids[contactsoldid]
	contactinfo << contactsnewid
	if contactsnewid != nil
		rows << contactinfo

	end
end


File.open("livecsv/out.csv", "w") {|f| f.write(rows.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}