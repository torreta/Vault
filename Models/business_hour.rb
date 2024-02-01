class BusinessHour < ApplicationRecord
  belongs_to :address
  has_one :provider, through: :address
  has_one :user, through: :provider
  has_many :appointments, dependent: :restrict_with_error
  
  # before_destroy :check_appointments


  validates :address, uniqueness: {scope: [:address_id, :hour_start, :hour_finish]}

  def as_json(options={})
    options = {
      :except => [:created_at, :updated_at],
      :include => [:address],
      :methods => [:user_email]
    }.merge(options)

    response = super(options)

    if (options.has_key? :destination) && (response.has_key? 'address')
      response['address']['distance'] = distance(options[:destination])
    end

    response

  end
  
  def category_id
    self.address.category_id
  end

  def provider_id
    self.address.provider_id
  end
  
  def category
    Category.find(self.address.category_id)
  end
  
  def type
    self.schedule_type
  end

  def service_id
    self.schedule_type
  end
  
  def schedule_type
    @type = CategoryService.where(category_id: self.address.category_id)
    @type.first.service_id
  end


  def refresh_schedules
    self.provider.refresh_schedules
  end


  def user_email
    self.provider.user.email
  end


  def internal_plain_type
    @internal_type_id  = CategoryService.where(category_id: self.address.category_id).first&.service_id
      
    case @internal_type_id
    when 1
      "medical"
    when 2
      "generic"
    else
      "other"
    end
  end


  def rebuild_schedule
    self.provider.rebuild_schedule
  end


  def check_new_schedule_collision(bh_to_evaluate)
    return self.horas_solapadas2(bh_to_evaluate)
  end


  def check_update_schedule_collision(bh_to_evaluate)
    
    # como hacerlo?
    # busco todas las horas asociadas al proveedor
    @bhe = bh_to_evaluate

    @business_hour = BusinessHour.find(bh_to_evaluate.id)

    @provider_id = @business_hour.provider.id

    @adresses_provider_ids = Address.where(provider_id: @provider_id).ids

    # por suerte si le das un arrray el saba interpretar que es un where in...
    @provider_bhs = BusinessHour.where(address_id: @adresses_provider_ids).where.not(id: bh_to_evaluate.id)


    # por defecto, solo se permiten horarios que no den conflictos entre ellos
    # asi que por defecto los horarios no estan solapados
    # por lo tanto, usarre esta variable para guardar el estado de solapado.
    @horas_solapadas = false; 

    # horario por horario, comparo si el proveedor tiene horas que choquen, y
    # de este modo determino si se solapa alguna

    # si el proveedor no tiene otro registro de horario por defecto no solapa
    # si el usuario tiene un solo registro de horario por defecto no solapa
    if @provider_bhs.count == 0
      return false;
    end

    # tienen que ser 2 al menos para que el siguiente ciclo haga su trabajo
    # de comprarar los horarios con sus siguientes.
    # ejem: 

      # todos los horarios existentes del proveedor.
      @provider_bhs.each do |bha|
    
        # reviso sino solapan sus horas del actual con el que se esta evaluando
        if (
            # si empieza a la misma hora que otro horario registrado 
            (bha.hour_start == @bhe.hour_start) or 
            # si termina a la misma hora que otro horario registrado
            (bha.hour_finish == @bhe.hour_finish) or 
            # si comienza antes que un horario ya registrado y termina antes que la hora inicial de dicho horario
            ((bha.hour_start > @bhe.hour_start) and (bha.hour_start < @bhe.hour_finish)) or 
            # si comienza antes que otro horario registrado termine y a su vez  termina despues de que ese otro horario termine 
            ((bha.hour_finish > @bhe.hour_start) and (bha.hour_finish < @bhe.hour_finish))
          )
          # reviso sino concuerdan alguno de sus dias, con alguno ya registrado
          if (
              (bha.monday and @bhe.monday) or 
              (bha.tuesday and @bhe.tuesday) or 
              (bha.wednesday and @bhe.wednesday) or 
              (bha.thursday and @bhe.thursday) or 
              (bha.friday and @bhe.friday) or 
              (bha.saturday and @bhe.saturday) or 
              (bha.sunday and @bhe.sunday)
            )
              # de llegar aqui, no hace falta que pase mas de una vez.
              # (pero estoy dejando que termine sus ciclos)
              # podria hacer que termine directamente con return true, pero
              # lo prefiero asi por legibilidad
              @horas_solapadas = true
          end
        end
  
      end

    # aviso si esta solapada o no. (booleano)
    return @horas_solapadas

  end


  # tomas una hora y evalua si da conflicto con alguna de los otros horarios
  # ya registrados en el proveedor
  def horas_solapadas2(bh_to_evaluate)
    # buscando los otros datos que necesito para procesar el horario
    @address = Address.find(bh_to_evaluate.address_id)
    @provider = Provider.find(@address.provider_id)


    # bh
    # id: 42,
    # address_id: 26,
    # hour_start: Sat, 01 Jan 2000 07:00:00 UTC +00:00,
    # hour_finish: Sat, 01 Jan 2000 14:30:00 UTC +00:00,
    # appointment_duration: 60,
    # name: "Caracas",
    # monday: true,
    # tuesday: false,
    # wednesday: true,
    # thursday: false,
    # friday: false,
    # saturday: false,
    # sunday: false,

    # address
    # id: 26,
    # address: "Av. Orinoco No. 56, Puerto Ayacucho, Estado Amazonas",
    # provider_id: 1,
    # category_id: 19,

    # providers
    # id: 1,
    # user_id: 2,
    # hour_start: Sat, 01 Jan 2000 07:00:00 UTC +00:00,
    # hour_finish: Sat, 01 Jan 2000 17:30:00 UTC +00:00,
    # monday: true,
    # tuesday: false,
    # wednesday: false,
    # thursday: false,
    # friday: false,
    # saturday: false,
    # sunday: false,

    # caviot
    # el horario en profile debe, reflejar la suma de todos los horarios.
    # su maxima hora de inicio, su maxima hora fin.
    # y la totalidad de todos los dias que trabajado

    # que tengo que validar.... 
    # en todas sus direcciones, hay que verificar esto.
    # 1. que no choque en dias con otro horario. sino choca con otro horario asociado.
    # entonces no hay problemas
    # 2. si hay otro horario en los mimos dias, verificar que las horas no se solapen
    # de solapar, avisar, tanto dia como hora en mensaje. (trow error.)

    # como hacerlo?
    # busco todas las horas asociadas al proveedor
    @provider_bhs = @provider.business_hours

    # por defecto, solo se permiten horarios que no den conflictos entre ellos
    # asi que por defecto los horarios no estan solapados
    # por lo tanto, usarre esta variable para guardar el estado de solapado.
    @horas_solapadas = false; 


    # horario por horario, comparo si el proveedor tiene horas que choquen, y
    # de este modo determino si se solapa alguna

    # si el usuario no tiene otro registro de horario por defecto no solapa
    if @provider_bhs.count == 0
      return false;
    end

    # alias mas corto
    @bhe = bh_to_evaluate

    # todos los horarios existentes del proveedor.
    @provider_bhs.each do |bha|

      # reviso sino solapan sus horas del actual con el que se esta evaluando
      if (
          # si empieza a la misma hora que otro horario registrado 
          (bha.hour_start == @bhe.hour_start) or 
          # si termina a la misma hora que otro horario registrado
          (bha.hour_finish == @bhe.hour_finish) or 
          # si comienza antes que un horario ya registrado y termina antes que la hora inicial de dicho horario
          ((bha.hour_start > @bhe.hour_start) and (bha.hour_start < @bhe.hour_finish)) or 
          # si comienza antes que otro horario registrado termine y a su vez  termina despues de que ese otro horario termine 
          ((bha.hour_finish > @bhe.hour_start) and (bha.hour_finish < @bhe.hour_finish))
        )
        # reviso sino concuerdan alguno de sus dias, con alguno ya registrado
        if (
            (bha.monday and @bhe.monday) or 
            (bha.tuesday and @bhe.tuesday) or 
            (bha.wednesday and @bhe.wednesday) or 
            (bha.thursday and @bhe.thursday) or 
            (bha.friday and @bhe.friday) or 
            (bha.saturday and @bhe.saturday) or 
            (bha.sunday and @bhe.sunday)
          )
            # de llegar aqui, no hace falta que pase mas de una vez.
            # (pero estoy dejando que termine sus ciclos)
            # podria hacer que termine directamente con return true, pero
            # lo prefiero asi por legibilidad
            @horas_solapadas = true
        end
      end

    end

    # dice si esta solapada o no.
    return @horas_solapadas
  end


  # Esto se hace porque cuando se agregan business_hours a traves de los seeds, las hour_start y hour_finish de provider no se colocan como deberian (la menor hour_start y la mayor hour_finish)
  def self.provider_update(bh)
    if !bh.check_new_schedule_collision(bh)
      if bh.save
        return bh, status: :created, location: bh
      else
        return bh.errors, status: :unprocessable_entity
      end
    else
      return false
    end
  end

  def horas_solapadas(bh)
    bh.check_new_schedule_collision(bh)
  end

  def provider_update(bh)
    if !bh.check_new_schedule_collision(bh)
      if bh.save
        return bh, status: :created, location: bh
      else
        return bh.errors, status: :unprocessable_entity
      end
    else
      return false
    end
  end

  def medical_update(bh)
      self.provider.reform_medical_schedule
  end

  def generic_update(bh)
      self.provider.reform_generic_schedule
  end

  def slots(blacklist={})
    slots = []

    (hour_start.to_datetime.to_i..(hour_finish-appointment_duration.minute).to_datetime.to_i).step(appointment_duration.minute) do |slot|
      next if blacklist.include? Time.at(slot)
      slots.push({start: Time.at(slot).utc, end: Time.at(slot).utc+appointment_duration.minute, duration: appointment_duration, business_hour_id: id })
    end

    slots
  end  

  def days_by_number
    days = []

    if monday
      days.push(1)
    end
    if tuesday
      days.push(2)
    end
    if wednesday
      days.push(3)
    end
    if thursday
      days.push(4)
    end
    if friday
      days.push(5)
    end
    if saturday
      days.push(6)
    end
    if sunday
      days.push(7)
    end

    days
  end

  def provider_days_by_number
    days = []

    # tuneado, borrar si jode
    address = Address.find(address_id)
    provider = Provider.find(address.provider_id)

    # puts "AQUI ADDRESS ID"
    # puts address_id

    if provider.monday
      days.push(1)
    end
    if provider.tuesday
      days.push(2)
    end
    if provider.wednesday
      days.push(3)
    end
    if provider.thursday
      days.push(4)
    end
    if provider.friday
      days.push(5)
    end
    if provider.saturday
      days.push(6)
    end
    if provider.sunday
      days.push(7)
    end

    days
  end

  def days_by_name

    days = []

    if monday
      days.push('monday')
    end
    if tuesday
      days.push('tuesday')
    end
    if wednesday
      days.push('wednesday')
    end
    if thursday
      days.push('thursday')
    end
    if friday
      days.push('friday')
    end
    if saturday
      days.push('saturday')
    end
    if sunday
      days.push('sunday')
    end

    days
  end

  def days_amount

    days = 0

    if monday
      days += 1
    end
    if tuesday
      days += 1
    end
    if wednesday
      days += 1
    end
    if thursday
      days += 1
    end
    if friday
      days += 1
    end
    if saturday
      days += 1
    end
    if sunday
      days += 1
    end

    days
  end

  def distance(destination={})
    address.distance(destination)
  end

  def user_email
    self.provider.user.email
  end

  def destroy2
    # Check if the business   hour is associated with any appointments.
    if appointments.any?
      errors.add(:base, "Cannot delete business hour with associated appointments.")
      return false
    end

    # Check if the business hour is associated with any blocked times.
    # if blocked_times.any?
    #     errors.add(:base, "Cannot delete business hour with associated blocked times.")
    #   return false
    # end

    # Destroy the business hour if there are no associated appointments or blocked times.
    if errors.empty?
      destroy
    end
  end

  def check_appointments
    
    logger.debug("-==============================================")        
    logger.debug("Verificando citas en horario espeficico")        
    logger.debug("-==============================================") 

    @citas = false

    if self.appointments.any? 
      # errors.add(:base, "Cannot delete business hour with associated appointments or blocked times.")
      @citas = true
    end

    return @citas

    # blocked bussiness hours? ver si eso es factible porque tiene citas que aun no se han cumplido
    # si la persona tiene un pago hecho el proveedor tiene que solucionar con "pago externo"

  end

  def appointments_pending
    self.appointments.where(appointment_status_id: [1,2]).or(self.appointments.where('date_start >= ?', Date.current) )
  end

  def appointments_pending?
    @check = false
    
    if self.appointments_pending.any?
      @check = true
    end
    
    return @check
  end


  def time_intervals_overlap?(interval1, interval_2, date)
    # Convert the date to a Date object
    date = Date.parse(date)
  
    # Combine the date and time intervals to create two ranges of date and time
    combined_interval1 = date.all_day + interval1
    combined_interval2  = date.all_day + interval2
  
    # Check if the two combined intervals overlap
    overlap = combined_interval1 & combined_interval2
  
    # Check if there are any records in the model that conflict with the overlapping time interval
    # conflicting_records = model.where(time_interval: overlap).count > 0
  
    # Return true if there is an overlap and conflicting records, false otherwise
    # overlap && conflicting_records
    overlap
  end
  

end
