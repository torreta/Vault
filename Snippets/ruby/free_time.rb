def free_slots
  page_size = 7
  offset = 0

  if params[:page].present? && params[:page].to_i > 0
    offset = params[:page].to_i - 1
  end

  # Create a range of <page_size> dates
  start_date = Date.today + page_size * offset
  end_date = start_date + page_size

  puts "estoy testeando que las citas esten detectando.. pre condicion"

  # aqui, colocar los slots, que sean especificos de la cita.
  if params[:appointment_id].present?
    puts "estoy testeando que las citas esten detectando.."
    @appointment = Appointment.find(params[:appointment_id])
    if @appointment.appointment_type_id == 2
      start_date = @appointment.date_start
      end_date = @appointment.date_finish
      # Ensure start_date is not greater than end_date
      if start_date > end_date
        start_date, end_date = end_date, start_date
      end
    end
  end
  
  if params[:current_date].present?
    if params[:current_date] != 'undefined'
      start_date = Date.parse(params[:current_date])
      # Ensure end_date is at least start_date + page_size
      # i got to make sure the range ends...
      # end_date = [end_date, start_date + page_size].max
    end
  end

  puts "Start Date: #{start_date}"
  puts "End Date: #{end_date}"

  # Get free business hour free slots per date
  @slots = @provider.free_slots_between_dates(params[:business_hour_id], start_date, end_date)

  # filtrar los que son de este mismo dia. y la hora ya paso
  @slots.reject! { |e| (Date.parse(e[:date].to_s) == Date.today && Time.parse(e[:end].to_s) <= Time.now) }

  @slots.uniq! { |slot| [slot[:date], slot[:start], slot[:end]] }

  # Drop elements from the start of the list based on the page number
  # drop_count = page_size * params[:page].to_i
  # @slots = @slots.drop(drop_count)

  render json: @slots
end