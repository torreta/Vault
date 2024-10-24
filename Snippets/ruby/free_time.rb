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
    end
  end

  # Get free business hour free slots per date
  @slots = @provider.free_slots_between_dates(params[:business_hour_id], start_date, end_date)

  # filtrar los que son de este mismo dia. y la hora ya paso
  @slots.reject! { |e| (Date.parse(e[:date].to_s) == Date.today && Time.parse(e[:end].to_s) <= Time.now) }
  
  @slots.uniq! { |slot| [slot[:date], slot[:start], slot[:end]] }

  render json: @slots
end