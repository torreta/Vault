module DataInterpreterHelper

  
	def getTime(startTime, endTime, day, formatHour)
		valueDays = [false, false, false, false, false, false, false]
		valueDays[day.to_i - 1] = true
		return JSON.parse({ hour_start: startTime, hour_finish: endTime, days: valueDays }.to_json, {:symbolize_names => true})
	end

  
	def transform_applied_studies_form_array_into_string(numOfstudies)
		i = 1
		applied_studies = ''

		while i <= numOfstudies do
			if i < numOfstudies
				applied_studies += params['studies'+i.to_s] + ', '
			else
				applied_studies += params['studies'+i.to_s]
			end
			i+=1
		end
		return applied_studies
	end


	def getArrayTime(businessHour)
		valueDays = []
		
		if businessHour[:monday]
			valueDays.push(0)
		end
		if businessHour[:tuesday]
			valueDays.push(1)
		end
		if businessHour[:wednesday]
			valueDays.push(2)
		end
		if businessHour[:thursday]
			valueDays.push(3)
		end
		if businessHour[:friday]
			valueDays.push(4)
		end
		if businessHour[:saturday]
			valueDays.push(5)
		end
		if businessHour[:sunday]
			valueDays.push(6)
		end
		
		businessHour.delete(:monday)
		businessHour.delete(:tuesday)
		businessHour.delete(:wednesday)
		businessHour.delete(:thursday)
		businessHour.delete(:friday)
		businessHour.delete(:saturday)
		businessHour.delete(:sunday)
		
		businessHour[:days] = valueDays
		businessHour[:numOfHours] = valueDays.length
		
		return businessHour
	end


	def get_schedules(days, start_time, end_time, id)
		schedules = []
		
		i = 0 
		d = 0
		
		while d < days.length
				data = {
						"id" => id[i] || nil,
						"days" => days.slice(d, 7),
						"start_time" => start_time[i],
						"end_time" => end_time[i]
				}
				
				i += 1
				d += 7
				schedules.push(data)
		end
		

		schedules
end


def get_values_of_params(data, params, index, fields = []) 
		fields.each do |field|
				data[field] = params["#{field}#{index}"]
		end
end


def get_business_address_and_its_schedules params
		addresses = [] 
		counted = params["days"].length
		
		counted.times do |n|
				data = {}
				get_values_of_params(data, params, n + 1, [
						"addressC",
						"siteName",
						"longitude",
						"latitude",
						"phone",
						"address",
						"reference",
						"timeSpam",
						"numOfHours",
				])
				
				data["schedules"] = get_schedules(params["days"]["#{n}"], params["start_time"]["#{n}"], params["end_time"]["#{n}"], params["schedule_id"]["#{n}"])
				
				addresses.push(data)
		end
		
		addresses
end

def eliminate_duplicate_schedules sites
	
	addresses = []
	last_schedule_id = nil
		
	sites.each do |site|
		site["schedules"].each do |schedule|
			if schedule['id'] == last_schedule_id
				schedule['id'] = ""
			else
				last_schedule_id = schedule['id']
			end
		end
	end

	sites
end

end