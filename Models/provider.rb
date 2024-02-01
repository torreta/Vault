class Provider < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :addresses
  has_many :business_hours, through: :addresses
  has_many :appointments
  has_many :customer_cards
  has_many :provider_favorites, through: :user
  
  has_one :generic_profile
  has_one :medical_profile
  
  require 'stripe'
  require 'socket'


  def as_json(options={})
    options = {
      :include => [
        :user => {:only => [:name, :email, :avatar_file_name, :speciality, :profile, :stripe_account_id, :stripe_customer_id]},
        :addresses => {:only => [:address, :latitude, :longitude, :phone, :provider_id, :reference]},
      ],
      :except => [:created_at, :updated_at],
      :methods => [:true_avatar_url, :avatar_url, :email, :avatar_file_name, :speciality, :profile, :service, :medical_business_hour, :generic_business_hour,:medical_info, :generic_info, :stripe_account, :stripe_ready, :stripe_account_id, :stripe_customer_id]

    }.merge(options)

    super(options)
  end


  def local_ip
    orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true  # turn off reverse DNS resolution temporarily
  
    UDPSocket.open do |s|
      s.connect '64.233.187.99', 1
      s.addr.last
    end
  ensure
    Socket.do_not_reverse_lookup = orig
  end

  
  def email
    user.email
  end  

  def avatar_url
    user.avatar.url(:thumb)
  end    


  def true_avatar_url
    user.avatar_content_type.url
  end  


  def avatar_file_name

    if user.avatar_file_name != nil
      user.avatar_file_name
    else
      # nombre del avatar por defecto
      @missing = 'missing.png'
    end

  end  


  def profile
    @profile = UsersProfile.where(user_id: user.id).first
    return @profile
  end

  def appointments_pending
    self.business_hours.first.appointments_pending
  end

  def appointments_pending?
    self.business_hours.first.appointments_pending.any?
  end


  def stripe_account
    
    if self.profile_type == "none"
      return false
    end

    self.user.sync_stripe

    return self.user.stripe_account_id

  end


  def profile_type
  
    if MedicalProfile.exists?(provider_id: self.id)
      return "medical"
    end

    if GenericProfile.exists?(provider_id: self.id)
      return "generic"
    end

    return "none"
  end


  def medical?
    return MedicalProfile.exists?(provider_id: self.id)
  end


  def generic?
    return GenericProfile.exists?(provider_id: self.id)
  end


  def customer_profile
  
    if Customer.where(user_id: self.user_id).count > 0
      return Customer.where(user_id: self.user_id).first
    else
      return false
    end
  
  end


  def is_complete?
    
    @complete = true

    if (self.hour_start == nil)
      return false
    end

    if (self.hour_finish == nil)
      return false
    end

    if (self.monday == nil)
      return false
    end

    if (self.tuesday == nil)
      return false
    end

    if (self.wednesday == nil)
      return false
    end
    if (self.thursday == nil)
      return false
    end

    if (self.friday == nil)
      return false
    end
  
    if (self.saturday == nil)
      return false
    end

    if (self.sunday == nil)
      return false
    end

    return @complete

  end


  def tos_acceptance
    Stripe::Account.update(
      self.stripe_account,
      {
        tos_acceptance: {
          date: Time.now.to_i,
          ip: self.local_ip, # Assumes you're not using a proxy
        },
      }
    )
  end 


  def working_profile

    if MedicalProfile.exists?(provider_id: self.id)
      return self.medical_profile
    end

    if GenericProfile.exists?(provider_id: self.id)
      return self.generic_profile
    end

    return nil

  end
  

  def medical_business_hour
    @provider = Provider.where(user_id: user.id).first
    if MedicalProfile.where(provider_id: @provider.id).count != 0

      # los perfiles por categoria, solo puede existir uno por usuario...
      # de alli que esta busqueda ubique solo el primero
      @medical_profile = MedicalProfile.where(provider_id: @provider.id).first

      @medical_business_hour = Hash.new

      # resumiendo el modo en que se colocan los dias
      @medical_business_hour['monday'] = @medical_profile.monday || false 
      @medical_business_hour['tuesday'] = @medical_profile.tuesday || false
      @medical_business_hour['wednesday'] = @medical_profile.wednesday || false
      @medical_business_hour['thursday'] = @medical_profile.thursday || false
      @medical_business_hour['friday'] = @medical_profile.friday || false
      @medical_business_hour['saturday'] = @medical_profile.saturday || false
      @medical_business_hour['sunday'] = @medical_profile.sunday || false

      # resumiendo las horas que trabaja
      @medical_business_hour['hour_start'] = @medical_profile.hour_start || false
      @medical_business_hour['hour_finish'] = @medical_profile.hour_finish || false
      
      return @medical_business_hour
    else
      return false
    end
  end

  
  def medical_info
    @provider = Provider.where(user_id: user.id).first
    if MedicalProfile.where(provider_id: @provider.id).count != 0

      # los perfiles por categoria, solo puede existir uno por usuario...
      # de alli que esta busqueda ubique solo el primero
      @medical_profile = MedicalProfile.where(provider_id: @provider.id).first

      @medical_business_hour = Hash.new

      # resumiendo el sus servicios.
      @medical_business_hour['CMP'] = @medical_profile.CMP || false 
      @medical_business_hour['RNE'] = @medical_profile.RNE || false 
      @medical_business_hour['applied_studies'] = @medical_profile.applied_studies || false
      @medical_business_hour['service_that_provides'] = @medical_profile.service_that_provides || false
      
      return @medical_business_hour
    else
      return false
    end
  end


  def generic_business_hour
    @provider = Provider.where(user_id: user.id).first
    if GenericProfile.where(provider_id: @provider.id).count != 0 

      # los perfiles por categoria, solo puede existir uno por usuario...
      # de alli que esta busqueda ubique solo el primero
      @generic_profile = GenericProfile.where(provider_id: @provider.id).first

      @generic_business_hour = Hash.new

      # resumiendo el modo en que se colocan los dias
      @generic_business_hour['monday'] = @generic_profile.monday || false
      @generic_business_hour['tuesday'] = @generic_profile.tuesday || false
      @generic_business_hour['wednesday'] = @generic_profile.wednesday || false
      @generic_business_hour['thursday'] = @generic_profile.thursday || false
      @generic_business_hour['friday'] = @generic_profile.friday || false
      @generic_business_hour['saturday'] = @generic_profile.saturday || false
      @generic_business_hour['sunday'] = @generic_profile.sunday || false

      # resumiendo las horas que trabaja
      @generic_business_hour['hour_start'] = @generic_profile.hour_start || false
      @generic_business_hour['hour_finish'] = @generic_profile.hour_finish || false
    
      return @generic_business_hour
    else
      return false
    end
  end


  def generic_info
    @provider = Provider.where(user_id: user.id).first
    if GenericProfile.where(provider_id: @provider.id).count != 0 

      # los perfiles por categoria, solo puede existir uno por usuario...
      # de alli que esta busqueda ubique solo el primero
      @generic_profile = GenericProfile.where(provider_id: @provider.id).first

      @generic_business_hour = Hash.new

      # resumiendo el modo en que se colocan los dias
      @generic_business_hour['CMP'] = @generic_profile.CMP || false
      @generic_business_hour['applied_studies'] = @generic_profile.applied_studies || false
      @generic_business_hour['service_that_provides'] = @generic_profile.service_that_provides || false

      return @generic_business_hour
    else
      return false
    end
  end


  def valid_schedule?
    # la idea de este metodo es evaluar sin necesidad de querer evaluar un nuevo horario
    # sino solo los que ya tiene registrado. 

    # de momento para a validar:
    # 1. que el usuario no tiene horas solapadas. (retroactivo, si el usuario fue creado manualmente e invalido)

    @valid = true

    # 1. verificar que las horas no se solapen
    if self.horas_solapadas?
      @valid = false
    end

    # 2. de momento no hay otros criterios, pero aqui en adelante se agregan  

    @valid

  end


  def horas_solapadas?

    # como hacerlo?
    # busco todas las horas asociadas al proveedor
    @provider_bhs = self.business_hours

    # por defecto, solo se permiten horarios que no den conflictos entre ellos
    # asi que por defecto los horarios no estan solapados
    # por lo tanto, usarre esta variable para guardar el estado de solapado.
    @horas_solapadas = false; 


    # horario por horario, comparo si el proveedor tiene horas que choquen, y
    # de este modo determino si se solapa alguna

    # si el proveedor no tiene otro registro de horario por defecto no solapa
    # si el usuario tiene un solo registro de horario por defecto no solapa
    if @provider_bhs.count == 0 || @provider_bhs.count == 1
      return false;
    end

    # tienen que ser 2 al menos para que el siguiente ciclo haga su trabajo
    # de comprarar los horarios con sus siguientes.
    # ejem: 
    # (ayuda: saltar el primer elemento del each)
    # [1,2,3].drop(1).each {|x| puts x }
    while @provider_bhs.count >= 2

      # agarro un horario a evaluar
      @bhe = @provider_bhs.first

      # todos los horarios existentes del proveedor.
      @provider_bhs.drop(1).each do |bha|
    
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

      # evaluo los mismos pero quito 1, para iterarlos todos
      @provider_bhs =  @provider_bhs.drop(1) 

    end

    # aviso si esta solapada o no. (booleano)
    return @horas_solapadas

  end


  def rebuild_schedule
    # an alias funtion
    self.reform_schedule
  end


  def refresh_schedules
    # an alias funtion
    self.reform_schedule

    if self.medical?
      self.reform_medical_schedule
    end

    if self.generic?
      self.reform_generic_schedule
    end
  
  end


  def reform_schedule
    
    @provider = self

    @business_hours = @provider.business_hours

    # si el usuario no tiene horarios registrados
    # posible: si se borro o esta editando su unico horario disponible
    
    @monday = false
    @tuesday = false
    @wednesday = false
    @thursday = false
    @friday = false
    @saturday = false
    @sunday = false

    @hour_start = nil
    @hour_finish = nil


    @business_hours.each do |bh|

      if @hour_start.nil? 
        # si el valor esta vacio, asino este
        @hour_start = bh.hour_start
      else
        # la hora de entrada mas temprana:
        # si el valor es menor al actual, asigno ese, sino, continuo con el anterior (hablo de horas, mas temprano)
        @hour_start = (bh.hour_start < @hour_start) ? bh.hour_start : @hour_start
      end

      if @hour_finish.nil? 
        # si el valor esta vacio, asino este
        @hour_finish = bh.hour_finish
      else
        # la hora de salida mas tarde:
        # si el valor es mayor al actual, asigno ese, sino, continuo con el anterior (hablo de horas, mas tarde)
        @hour_finish = (bh.hour_finish > @hour_finish) ? bh.hour_finish : @hour_finish
      end

        # si alguno de los valores llega a ser verdadero durante el ciclo se mantendra verdadero
        @monday = @monday || bh.monday
        @tuesday = @tuesday || bh.tuesday
        @wednesday = @wednesday || bh.wednesday
        @thursday = @thursday || bh.thursday
        @friday = @friday || bh.friday
        @saturday = @saturday || bh.saturday
        @sunday = @sunday || bh.sunday

    end

      @provider.monday = @monday
      @provider.tuesday = @tuesday
      @provider.wednesday = @wednesday
      @provider.thursday = @thursday
      @provider.friday = @friday
      @provider.saturday = @saturday
      @provider.sunday = @sunday
  
      @provider.hour_start = @hour_start
      @provider.hour_finish = @hour_finish

      @provider.save

      return true

  end


  def reform_medical_schedule
    
    @provider = self

    @business_hours = @provider.business_hours

    @monday = false
    @tuesday = false
    @wednesday = false
    @thursday = false
    @friday = false
    @saturday = false
    @sunday = false

    @hour_start = nil
    @hour_finish = nil

    # current reform
    @medical_profile = @provider.medical_profile


    @business_hours.each do |bh|

      if bh.internal_plain_type == "medical"
        
        if @hour_start.nil? 
          # si el valor esta vacio, asino este
          @hour_start = bh.hour_start
        else
          # la hora de entrada mas temprana:
          # si el valor es menor al actual, asigno ese, sino, continuo con el anterior (hablo de horas, mas temprano)
          @hour_start = (bh.hour_start < @hour_start) ? bh.hour_start : @hour_start
        end

        if @hour_finish.nil? 
          # si el valor esta vacio, asino este
          @hour_finish = bh.hour_finish
        else
          # la hora de salida mas tarde:
          # si el valor es mayor al actual, asigno ese, sino, continuo con el anterior (hablo de horas, mas tarde)
          @hour_finish = (bh.hour_finish > @hour_finish) ? bh.hour_finish : @hour_finish
        end

          # si alguno de los valores llega a ser verdadero durante el ciclo se mantendra verdadero
          @monday = @monday || bh.monday
          @tuesday = @tuesday || bh.tuesday
          @wednesday = @wednesday || bh.wednesday
          @thursday = @thursday || bh.thursday
          @friday = @friday || bh.friday
          @saturday = @saturday || bh.saturday
          @sunday = @sunday || bh.sunday
      end

    end

      @medical_profile.monday = @monday
      @medical_profile.tuesday = @tuesday
      @medical_profile.wednesday = @wednesday
      @medical_profile.thursday = @thursday
      @medical_profile.friday = @friday
      @medical_profile.saturday = @saturday
      @medical_profile.sunday = @sunday
  
      @medical_profile.hour_start = @hour_start
      @medical_profile.hour_finish = @hour_finish

      @medical_profile.save

      return true

  end


  def reform_generic_schedule
    
    @provider = self

    @business_hours = @provider.business_hours

    @monday = false
    @tuesday = false
    @wednesday = false
    @thursday = false
    @friday = false
    @saturday = false
    @sunday = false

    @hour_start = nil
    @hour_finish = nil

    # current reform
    @generic_profile = @provider.generic_profile


    @business_hours.each do |bh|

      if bh.internal_plain_type == "generic"

        if @hour_start.nil? 
          # si el valor esta vacio, asino este
          @hour_start = bh.hour_start
        else
          # la hora de entrada mas temprana:
          # si el valor es menor al actual, asigno ese, sino, continuo con el anterior (hablo de horas, mas temprano)
          @hour_start = (bh.hour_start < @hour_start) ? bh.hour_start : @hour_start
        end

        if @hour_finish.nil? 
          # si el valor esta vacio, asino este
          @hour_finish = bh.hour_finish
        else
          # la hora de salida mas tarde:
          # si el valor es mayor al actual, asigno ese, sino, continuo con el anterior (hablo de horas, mas tarde)
          @hour_finish = (bh.hour_finish > @hour_finish) ? bh.hour_finish : @hour_finish
        end

          # si alguno de los valores llega a ser verdadero durante el ciclo se mantendra verdadero
          @monday = @monday || bh.monday
          @tuesday = @tuesday || bh.tuesday
          @wednesday = @wednesday || bh.wednesday
          @thursday = @thursday || bh.thursday
          @friday = @friday || bh.friday
          @saturday = @saturday || bh.saturday
          @sunday = @sunday || bh.sunday
      end

    end

      @generic_profile.monday = @monday
      @generic_profile.tuesday = @tuesday
      @generic_profile.wednesday = @wednesday
      @generic_profile.thursday = @thursday
      @generic_profile.friday = @friday
      @generic_profile.saturday = @saturday
      @generic_profile.sunday = @sunday
  
      @generic_profile.hour_start = @hour_start
      @generic_profile.hour_finish = @hour_finish

      @generic_profile.save

      return true

  end


  def service
    # este metodo tiene como intencion, decirte el nombre de los servicios
    # que tiene asociado el proveedor, "servicios varios, servicios medicos, restaurantes, etc"

    @provider = Provider.where(user_id: user.id).first
    @categories = CategoryProvider.where(provider_id: @provider.id)
    
    @services_ids = Array.new 

    @categories.each do |category|

      @services = CategoryService.where(category_id: category.category_id)

        @services.each do |service|
          # puts service
          @services_ids.push(service.service_id)
        end
    end

    i = 0
    @nombres_serv = ""

    # cada nombre de categoria
    @services_ids.each do |serv|

      if i == 0
        @nombres_serv = Service.find(serv).name
        i = i+1
      else
        @nombres_serv = @nombres_serv + ", "+ Service.find(serv).name
        i = i+1
      end

    end

    return @nombres_serv

  end  


  def speciality
    # este metodo tiene como funcionalidad, describir la especialidad del
    # proveedor, ej: "abogado, plomero, etc"
    @provider = Provider.where(user_id: user.id).first
    @categories = CategoryProvider.where(provider_id: @provider.id)

    @nombres = ""
    i = 0
    @categories.each do |category|

      if i == 0
        @nombres = Category.find(category.category_id).name
        i = i + 1;
      else
        @nombres = @nombres + ", "+ Category.find(category.category_id).name
        i = i + 1;
      end

    end
    # user.email
    return @nombres
  end


  def free_slots_between_dates(business_hour_id, start, finish)
    date_range = start..finish

    slots = []
    date_range.each do |date|
      slots.concat(free_slots_per_date(business_hour_id, date))
    end

    return slots
  end


  def free_slots_per_date(business_hour_id, date)

    if not BusinessHour.exists? business_hour_id
      return []
    end

    business_hour = business_hours.find(business_hour_id)

    if not business_hour.days_by_number.include? date.cwday
      return []
    end

    # Get all active appointments on the specified :date
    blacklist = appointments.not_canceled_or_hidden.where(date_start: date).distinct.pluck(:hour_start)

    business_hour.slots(blacklist).map{ |slot| {date: date}.merge(slot)}
  end


  def slots_between_dates(start, finish)
  # Provider schedule for a specified range of dates

    date_range = start..finish

    slots = []
    date_range.each do |date|
      slots.concat(slots_per_date(date))
    end

    return slots
  end


  def slots_per_date(date)
  # Provider schedule for a specified date

    slots = []
    date_schedule = []
    # Get date name. Ex: monday, tuesday, etc
    day_name = date.strftime("%A").downcase

    # Search business hours on that specified day
    # business_hours.where("#{day_name} = ?",1)

    # Get slots per business hour and merge them all
    business_hours.where("#{day_name} = ?",1).each do |business_hour|
      slots |= business_hour.slots
    end

    # Reorder the business hour
    # TODO: FIX THIS
    # slots = slots.sort_by{ |x| x.keys[0]}
    # slots = slots.reverse

    slots.each do |slot|

      # Get appointments for that hour
      date_appointments = appointments.approved_confirmed_paid.where(date_start: date).where(hour_start: slot[:start])
      # Mark slots as free or ocuppied depending if there is an appointment confirmed on that date/hour
      if date_appointments.empty?
        date_schedule.push({type: 'free', date: date, hour: slot[:start], slot: slot})
      else
        date_appointments.each do |date_appointment|
          date_schedule.push({type: 'occupied', date: date, hour: date_appointment.hour_start, slot: date_appointment})
        end
      end
    end

    return date_schedule
  end
  
  
  def check_stripe
    # legado para centralizar en el modelo user
    return self.user.sync_stripe
  end
  
  def stripe_account_id
    # legado para centralizar en el modelo user
    return self.user.stripe_account_id
  end
  
  def stripe_customer_id
    # legado para centralizar en el modelo user
    return self.user.stripe_customer_id
  end
  

  def stripe_account_info

    if self.stripe_id.nil?
      self.check_stripe
    end

    @account_stripe  = Stripe::Account.retrieve(self.stripe_id)

    @account_stripe

  end


  def stripe_ready
    # un alias, para que sea legible en los json
    # TODO el problema es que esto cambio mucho de parte del api, asi que de momento
    # NADIE debe ser stripe ready.
    self.properly_registered_stripe?
    
    # return true
    # return false
  end


  def properly_registered_stripe?

    if self.stripe_id.nil?
      self.check_stripe
    end

    # booleano para decir si el usuario esta correctamente registrado en stripe
    @valid = true

    @account_stripe  = Stripe::Account.retrieve(self.stripe_id)

    puts "<--------------------------- VERIFICACION ESTRIPE"
    puts @account_stripe
    puts "<--------------------------- VERIFICACION ESTRIPE END"

    if @account_stripe.respond_to?(:verification)
      if @account_stripe.verification.disabled_reason != nil
        puts 1
        return false
      end
    else
      # la cuenta nisiquiera tiene esa propiedad, lo cual indica la cuenta nisiquiera
      # tiene su unformacion basica completa.
      puts 2
      return false
    end

    # if @account_stripe.respond_to?(:business_name)
    #   if @account_stripe.business_name == nil
    #     # no tiene nombre de negocio registrado, lo cual es un campo requerido en stripe
    #     puts 3
    #     return false
    #   end
    # else
    #   # la cuenta nisiquiera tiene esa propiedad, lo cual indica la cuenta nisiquiera
    #   # tiene su unformacion basica completa.
    #   puts 4
    #   return false
    # end

    if @account_stripe.respond_to?(:display_name)
      if @account_stripe.display_name == nil
        # no tiene nombre de app, lo cual es un campo requerido en stripe
        puts 5
        return false
      end
    else
      # la cuenta nisiquiera tiene esa propiedad, lo cual indica la cuenta nisiquiera
      # tiene su unformacion basica completa.
      puts 6
      return false
    end


    if @account_stripe.respond_to?(:charges_enabled)
      if @account_stripe.charges_enabled == false
        # no puede hacer recargos
        puts 7
        return false
      end
    else
      # la cuenta nisiquiera tiene esa propiedad, lo cual indica la cuenta nisiquiera
      # tiene su unformacion basica completa.
      puts 8
      return false
    end


    if @account_stripe.respond_to?(:payouts_enabled)
      if @account_stripe.payouts_enabled == false
        # no puede hacersele pagos
        puts 9
        return false
      end
    else
      # la cuenta nisiquiera tiene esa propiedad, lo cual indica la cuenta nisiquiera
      # tiene su unformacion basica completa.
      puts 10
      return false
    end


    if @account_stripe.respond_to?(:details_submitted)
      if @account_stripe.details_submitted == false
        # no ha dado sus datos completos
        puts 11
        return false
      end
    else
      # la cuenta nisiquiera tiene esa propiedad, lo cual indica la cuenta nisiquiera
      # tiene su unformacion basica completa.
      puts 12
      return false
    end


    if @account_stripe.respond_to?(:tos_acceptance)
      if @account_stripe.tos_acceptance.ip == nil or @account_stripe.tos_acceptance.date == nil
        # no tiene aceptados los terminos de servicio
        puts 13
        return false
      end
    else
      # la cuenta nisiquiera tiene esa propiedad, lo cual indica la cuenta nisiquiera
      # tiene su unformacion basica completa.
      puts 14
      return false
    end


    # if @account_stripe.respond_to?(:legal_entity)
    #   if @account_stripe.legal_entity.business_tax_id_provided == false
    #     # no ha declarado su posicion fiscal
    #     puts 15
    #     return false
    #   end
    # else
    #   # la cuenta nisiquiera tiene esa propiedad, lo cual indica la cuenta nisiquiera
    #   # tiene su unformacion basica completa.
    #   puts 16
    #   return false
    # end


    if @account_stripe.respond_to?(:capabilities)
      if @account_stripe.capabilities.card_payments == "inactive" 
        # no puede hacer pagos con tarjetas
        puts 17
        return false
      end
      if @account_stripe.capabilities.platform_payments == "inactive" 
        # no puede hacer pagos por la plataforma
        puts 18
        return false
      end
    end

    # en fin, si algo de lo anterior en las validaciones falla el usuario 
    # no esta apropiadamente registrado en stripe
    @valid

  end



end
