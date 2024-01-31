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



  def check_new_schedule_collision(bh_to_evaluate)
    return self.horas_solapadas2(bh_to_evaluate)
  end


  def check_update_schedule_collision(bh_to_evaluate)
    
    # como hacerlo?
    # busco todas las horas asociadas al proveedor
    @bhe = bh_to_evaluate

    @business_hour = BusinessHour.find(bh_to_evaluate.id)

    @provider_id = @business_hour.provider.id

    @provider_bhs = BusinessHour.where(provider_id: @provider_id ).where.not(id: bh_to_evaluate.id)

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
    address = Address.find(bh.address_id)
    provider = Provider.find(address.provider_id)

    # Evaluar si las nuevas horas ingresadas no se solapan
    lista = BusinessHour.joins(:address).joins(:provider).where("addresses.provider_id = ?", provider.id)
    horas_solapadas = false
    lista.each do |l|
      # if (bh.hour_start > l.hour_start and bh.hour_start < l.hour_finish) or (bh.hour_finish > l.hour_start and bh.hour_finish < l.hour_finish)
      if ((bh.hour_start == l.hour_start) or (bh.hour_finish == l.hour_finish) or ((bh.hour_start > l.hour_start) and (bh.hour_start < l.hour_finish)) or ((bh.hour_finish > l.hour_start) and (bh.hour_finish < l.hour_finish)))
        if (bh.monday and l.monday) or (bh.tuesday and l.tuesday) or (bh.wednesday and l.wednesday) or (bh.thursday and l.thursday) or (bh.friday and l.friday) or (bh.saturday and l.saturday) or (bh.sunday and l.sunday)
          horas_solapadas = true
        end
      end
    end

    if horas_solapadas
      if bh.save
        return (!horas_solapadas)
      end
    else
      #Evaluando dia por dia si el provider trabaja en los mismos, en caso de que no, coloco false
      if provider.monday or bh.monday
        provider.update_attributes(:monday => true)
      else
        provider.update_attributes(:monday => false)
      end
      if provider.tuesday or bh.tuesday
        provider.update_attributes(:tuesday => true)
      else
        provider.update_attributes(:tuesday => false)
      end
      if provider.wednesday or bh.wednesday
        provider.update_attributes(:wednesday => true)
      else
        provider.update_attributes(:wednesday => false)
      end
      if provider.thursday or bh.thursday
        provider.update_attributes(:thursday => true)
      else
        provider.update_attributes(:thursday => false)
      end
      if provider.friday or bh.friday
        provider.update_attributes(:friday => true)
      else
        provider.update_attributes(:friday => false)
      end
      if provider.saturday or bh.saturday
        provider.update_attributes(:saturday => true)
      else
        provider.update_attributes(:saturday => false)
      end
      if provider.sunday or bh.sunday
        provider.update_attributes(:sunday => true)
      else
        provider.update_attributes(:sunday => false)
      end

      # Se le coloca al Provider la menor de todas las horas de entrada y la mayor de todas las horas de salida
      if provider.hour_start == nil 
        provider.update_attributes(:hour_start => bh.hour_start)
      else
        if provider.hour_start > bh.hour_start
          provider.update_attributes(:hour_start => bh.hour_start)
        end
      end

      if provider.hour_finish == nil 
        provider.update_attributes(:hour_finish => bh.hour_finish)
      else
        if provider.hour_finish < bh.hour_finish
          provider.update_attributes(:hour_finish => bh.hour_finish)
        end
      end
      self.medical_update(bh)
      self.generic_update(bh)
      if bh.save
        return bh, status: :created, location: bh
      else
        return bh.errors, status: :unprocessable_entity
      end
    end

  end

  def horas_solapadas(bh)
    address = Address.find(bh.address_id)
    provider = Provider.find(address.provider_id)

    # Evaluar si las nuevas horas ingresadas no se solapan
    lista = BusinessHour.joins(:address).joins(:provider).where("addresses.provider_id = ?", provider.id)
    horas_solapadas = false
    lista.each do |l|
      # if (bh.hour_start > l.hour_start and bh.hour_start < l.hour_finish) or (bh.hour_finish > l.hour_start and bh.hour_finish < l.hour_finish)
      if ((bh.hour_start == l.hour_start) or (bh.hour_finish == l.hour_finish) or ((bh.hour_start > l.hour_start) and (bh.hour_start < l.hour_finish)) or ((bh.hour_finish > l.hour_start) and (bh.hour_finish < l.hour_finish)))  
        if (bh.monday and l.monday) or (bh.tuesday and l.tuesday) or (bh.wednesday and l.wednesday) or (bh.thursday and l.thursday) or (bh.friday and l.friday) or (bh.saturday and l.saturday) or (bh.sunday and l.sunday)
          horas_solapadas = true
        end
      end
    end

    if horas_solapadas
      if bh.save
        return (!horas_solapadas)
      end
    else
      return horas_solapadas
    end
  end

  def provider_update(bh)
    address = Address.find(bh.address_id)
    provider = Provider.find(address.provider_id)

    # Evaluar si las nuevas horas ingresadas no se solapan
    lista = BusinessHour.joins(:address).joins(:provider).where("addresses.provider_id = ?", provider.id)
    horas_solapadas = false
    lista.each do |l|
      # if (bh.hour_start > l.hour_start and bh.hour_start < l.hour_finish) or (bh.hour_finish > l.hour_start and bh.hour_finish < l.hour_finish)
      puts("Afuera 1 :v")
      if ((bh.hour_start == l.hour_start) or (bh.hour_finish == l.hour_finish) or ((bh.hour_start > l.hour_start) and (bh.hour_start < l.hour_finish)) or ((bh.hour_finish > l.hour_start) and (bh.hour_finish < l.hour_finish))) 
        puts("Adentro 2 :v")
        if (bh.monday and l.monday) or (bh.tuesday and l.tuesday) or (bh.wednesday and l.wednesday) or (bh.thursday and l.thursday) or (bh.friday and l.friday) or (bh.saturday and l.saturday) or (bh.sunday and l.sunday)
          puts("Adentro 3 :v")
          horas_solapadas = true
        end
      end
    end

    if horas_solapadas
      if bh.save
        return (!horas_solapadas)
      end
    else
      #Evaluando dia por dia si el provider trabaja en los mismos, en caso de que no, coloco false
      if provider.monday or bh.monday
        provider.update_attributes(:monday => true)
      else
        provider.update_attributes(:monday => false)
      end
      if provider.tuesday or bh.tuesday
        provider.update_attributes(:tuesday => true)
      else
        provider.update_attributes(:tuesday => false)
      end
      if provider.wednesday or bh.wednesday
        provider.update_attributes(:wednesday => true)
      else
        provider.update_attributes(:wednesday => false)
      end
      if provider.thursday or bh.thursday
        provider.update_attributes(:thursday => true)
      else
        provider.update_attributes(:thursday => false)
      end
      if provider.friday or bh.friday
        provider.update_attributes(:friday => true)
      else
        provider.update_attributes(:friday => false)
      end
      if provider.saturday or bh.saturday
        provider.update_attributes(:saturday => true)
      else
        provider.update_attributes(:saturday => false)
      end
      if provider.sunday or bh.sunday
        provider.update_attributes(:sunday => true)
      else
        provider.update_attributes(:sunday => false)
      end

      # Se le coloca al Provider la menor de todas las horas de entrada y la mayor de todas las horas de salida
      if provider.hour_start == nil 
        provider.update_attributes(:hour_start => bh.hour_start)
      else
        if provider.hour_start > bh.hour_start
          provider.update_attributes(:hour_start => bh.hour_start)
        end
      end

      if provider.hour_finish == nil 
        provider.update_attributes(:hour_finish => bh.hour_finish)
      else
        if provider.hour_finish < bh.hour_finish
          puts(bh.hour_finish)
          provider.update_attributes(:hour_finish => bh.hour_finish)
        end
      end
        bh.medical_update(bh)
        bh.generic_update(bh)
        puts(bh.hour_finish)
      if bh.save
        return bh, status: :created, location: bh
      else
        return bh.errors, status: :unprocessable_entity
      end
    end
  end

  def medical_update(bh)
    address = Address.find(bh.address_id)
    provider = Provider.find(address.provider_id)
    puts(bh)
    puts("afuera")
    if CategoryService.find_by_category_id(Address.find(bh.address_id).category_id).service_id == 1
      puts("adentro")
      medical = MedicalProfile.find_by_provider_id(bh.address.provider_id)

      if bh.monday
        medical.update_attributes(:monday => true)
      else
        medical.update_attributes(:monday => false)
      end
      if bh.tuesday
        medical.update_attributes(:tuesday => true)
      else
        medical.update_attributes(:tuesday => false)
      end
      if bh.wednesday
        medical.update_attributes(:wednesday => true)
      else
        medical.update_attributes(:wednesday => false)
      end
      if bh.thursday
        medical.update_attributes(:thursday => true)
      else
        medical.update_attributes(:thursday => false)
      end
      if bh.friday
        medical.update_attributes(:friday => true)
      else
        medical.update_attributes(:friday => false)
      end
      if bh.saturday
        medical.update_attributes(:saturday => true)
      else
        medical.update_attributes(:saturday => false)
      end
      if bh.sunday
        medical.update_attributes(:sunday => true)
      else
        medical.update_attributes(:sunday => false)
      end

      puts(bh.hour_finish)
      # Se le coloca al medical la menor de todas las horas de entrada y la mayor de todas las horas de salida
      if medical.hour_start == nil
        medical.update_attributes(:hour_start => bh.hour_start)
      else
        if medical.hour_start > bh.hour_start
          medical.update_attributes(:hour_start => bh.hour_start)
        end
      end

      if medical.hour_finish == nil 
        medical.update_attributes(:hour_finish => bh.hour_finish)
      else
        if medical.hour_finish < bh.hour_finish
          puts("lo hice 10203")
          medical.update_attributes(:hour_finish => bh.hour_finish)
        end
      end
    end
  end

  def generic_update(bh)
    address = Address.find(bh.address_id)
    provider = Provider.find(address.provider_id)
    puts(bh)
    if CategoryService.find_by_category_id(Address.find(bh.address_id).category_id).service_id == 2
      generic = GenericProfile.find_by_provider_id(bh.address.provider_id)
      if bh.monday
        generic.update_attributes(:monday => true)
      else
        generic.update_attributes(:monday => false)
      end
      if bh.tuesday
        generic.update_attributes(:tuesday => true)
      else
        generic.update_attributes(:tuesday => false)
      end
      if bh.wednesday
        generic.update_attributes(:wednesday => true)
      else
        generic.update_attributes(:wednesday => false)
      end
      if bh.thursday
        generic.update_attributes(:thursday => true)
      else
        generic.update_attributes(:thursday => false)
      end
      if bh.friday
        generic.update_attributes(:friday => true)
      else
        generic.update_attributes(:friday => false)
      end
      if bh.saturday
        generic.update_attributes(:saturday => true)
      else
        generic.update_attributes(:saturday => false)
      end
      if bh.sunday
        generic.update_attributes(:sunday => true)
      else
        generic.update_attributes(:sunday => false)
      end

      # Se le coloca al generic la menor de todas las horas de entrada y la mayor de todas las horas de salida
      if generic.hour_start == nil 
        generic.update_attributes(:hour_start => bh.hour_start)
      else
        if generic.hour_start > bh.hour_start
          generic.update_attributes(:hour_start => bh.hour_start)
        end
      end

      if generic.hour_finish == nil 
        generic.update_attributes(:hour_finish => bh.hour_finish)
      else
        if generic.hour_finish < bh.hour_finish
          generic.update_attributes(:hour_finish => bh.hour_finish)
        end
      end
    end
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
    
    logger.debug("------------------================================--------------")        
    logger.debug("Verificando citas en horario espeficico")        
    logger.debug("------------------================================--------------") 

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
    self.appointments.where(appointment_status_id: [1,2]).where('date_start >= ?', Date.today())
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
