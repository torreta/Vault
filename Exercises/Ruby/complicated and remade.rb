
  # got to evaluate equivalency
  # aqui construyo, los datos para crear un business hour.
  while j <= numOfHours do
    index2 = j.to_s

    day = params['dayC'+index1+index2]

    startTimeHour = params['startTimeHourC'+index1+index2]
    endTimeHour = params['endTimeHourC'+index1+index2]

    if array.length == 0
      array.push(getTime(startTimeHour, endTimeHour, day, 0))
    else
      k = 0
      sameTime = false
      while k < array.length
        if array[k][:hour_start] == startTimeHour and array[k][:hour_finish] == endTimeHour
          sameTime = true
          array[k][:days][day.to_i - 1] = true
          break
        end
        k+=1
      end
      if sameTime == false
        array.push(getTime(startTimeHour, endTimeHour, day, 1))
      end
    end
    j +=1
  end

  # remade
  # llama code result
  params.each do |key, value|
    if key.start_with?('dayC') && value.present?
      unique_index = key.slice(4, key.length)
      day = params["dayC#{unique_index}"]
      startTimeHour = params["startTimeHourC#{unique_index}"]
      endTimeHour = params["endTimeHourC#{unique_index}"]
  
      sameTime = false
      array.each do |time|
        if time[:hour_start] == startTimeHour && time[:hour_finish] == endTimeHour
          sameTime = true
          time[:days][day.to_i - 1] = true
          break
        end
      end
  
      array.push(getTime(startTimeHour, endTimeHour, day, sameTime ? 1 : 0)) if !sameTime
    end
  end
