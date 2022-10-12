require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5,"0")[0..4]
end

def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  #begin
    #civic_info.representative_info_by_address(
      #address: zip,
      #levels: 'country',
      #roles: ['legislatorUpperBody', 'legislatorLowerBody']
   # ).officials
  #rescue
    #'You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  #end
end

def save_thank_you_letter(id,form_letter)
  Dir.mkdir('output') unless Dir.exist?('output')

  filename = "output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts form_letter
  end
end

puts 'EventManager initialized.'

contents = CSV.open(
  'event_attendees.csv',
  headers: true,
  header_converters: :symbol
)

template_letter = File.read('form_letter.erb')
erb_template = ERB.new template_letter

contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  #legislators = legislators_by_zipcode(zipcode)
  phone_number = row[:homephone]
  registration = row[:regdate]
	
  form_letter = erb_template.result(binding)

  save_thank_you_letter(id,form_letter)
end

def clean_phone_numbers(phone_number)
	nums = phone_number.split("")
	ints = ["0","1","2","3","4","5","6","7","8","9"]
	nums.delete_if {|char| !ints.include? char}
	clean_pnum = nums.join("")

	if clean_pnum.length = 10
		return clean_pnum
	elsif clean_pnum.length == 11 && clean_pnum[0]=="1"
		return clean_pnum[1..-1] 
	else
		return "0000000000"
	end
end

def peak_reg_hours(csv_file)
	contents = CSV.open(
	  csv_file,
	  headers: true,
	  header_converters: :symbol
	)

	hours = []
	
	contents.each do |row|
	  id = row[0]
	  regdate = row[:regdate]
	  reghour = regdate.split(" ")[1].split(":")[0]
	  hours.push(reghour)
	end
	
	hours_count = hours.tally
	p hours_count
	max = hours_count.max_by { |k,v| v}[1]
	common_hours = []
	hours_count.each do |key, value|
		if value == max
			common_hours.push(key)
		end
	end
			
	return common_hours
end
	
