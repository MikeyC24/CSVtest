require 'csv'


rows = []

counter = 0
until counter == 100
rows = CSV.open("livecsv/hassg.csv", 'r') { |csv| csv[counter].map}
counter += 1
end

File.open("testcsv/Contact.csv", "w") {|f| f.write(rows.inject([]) { |csv, row|  csv << CSV.generate_line(row) }.join(""))}
