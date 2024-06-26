def overview
  @anomalies = []
  @overview = {}

  # User-related checks
  check_user_associations

  # Provider-related checks (if applicable)
  check_provider_associations if self.is_provider?

  # Customer-related checks (if applicable)
  check_customer_associations if self.is_customer?

  @overview[:anomalies] = "Anomalias :  #{@anomalies.count} - #{@anomalies.join(", ")}"
  @overview[:anomalies_count] = @anomalies.count

  return @overview.as_json
end

private

def check_user_associations
  puts "Comprobaciones usuario de id: #{self.id}, name: #{self.name}, email: #{self.email }"
  puts "=============== USER ID ==================="

  # UserEmail
  @user_email_count = UserEmail.where(user_id: self.id).count
  puts "Tiene: #{@user_email_count}, deberia tener 1. (user_id)(user_emails)"
  @overview[:user_email] = @user_email_count
  add_anomaly('UserEmail invalido', 'Probable registro incompleto.') if @user_email_count != 1

  # UsersProfile
  @user_profile_count = UsersProfile.where(user_id: self.id).count
  puts "Tiene: #{@user_profile_count}, deberia tener 1. (user_id)(users_profile)"
  @overview[:user_profile] = @user_profile_count
  add_anomaly('UsersProfile invalido', 'Probable registro incompleto. (Creacion, mas no llenado de datos)') if @user_profile_count != 1

  # Notifications
  @notifications_count = Notification.where(user_id: self.id).count
  @notifications_count_sender = Notification.where(sender_id: self.id).count
  @overview[:notifications_received] = @notifications_count
  @overview[:notifications_sent] = @notifications_count_sender
  puts "Tiene: #{@notifications_count}, como user puede tener cualquier numero, como user o sender. (user_id)(notifications)"
  puts "Tiene: #{@notifications_count_sender}, como sender tener tener cualquier numero, como user o sender. (sender_id)(notifications)"
  add_anomaly('No tiene Notificaciones, cero actividad?') if @notifications_count == 0 || @notifications_count_sender == 0

  # Admin
  @admin_count = Admin.where(user_id: self.id).count
  puts "Tiene: #{@admin_count}, no mayor a 1, puede o no puede ser admin. (user_id)(admins)"
  @overview[:is_admin] = @admin_count > 1 ? true : false
  add_anomaly('Usuario tiene repetido su marca / registro de administrador') if @admin_count > 1

  # Favorites
  @favorites_count = Favorite.where(user_id: self.id).count
  @favorited_count = Favorite.where(favorite_id: self.id).count
  puts "Tiene: #{@favorites_count}, deberia tener 1. (user_id)(favorites)"
  puts "Tiene: #{@favorited_count}, deberia tener 1. (user_id)(favorites)"
  @overview[:favorites] = @favorites_count
  @overview[:favorited] = @favorited_count

  # Customer Favorites
  @customer_favorite_count = CustomerFavorite.where(user_id: self.id).count
  puts "Tiene: #{@customer_favorite_count}, puede tener 0. (user_id)(customer_favorites)"
  @overview[:customer_favorites] = @customer_favorite_count

  # Provider Favorites
  @provider_favorited_count = ProviderFavorite.where(user_id: self.id).count
  puts "Tiene: #{@provider_favorited_count}, puede tener 0. (user_id)(provider_favorites)"
  @overview[:customer_favorited] = @provider_favorited_count

  @overview[:is_customer] = self.is_customer?
  @overview[:is_provider] = self.is_provider? 
end

def check_provider_associations
  puts "=============== PROVIDER_ID ID ==================="
  @provider_id = Provider.where(user_id: self.id).first.id
  puts "Provider: (provider_id) #{@provider_id}"

  @overview[:provider_id] =  @provider_id

  # Categories
  @categories_count = CategoryProvider.where(provider_id: @provider_id).count
  puts "Tiene: #{@categories_count}, puede tener 0. (provider_id)(categories_provider)"
  @overview[:categories_count] = @categories_count

  # Customer Favorited
  @customer_favorited_count = CustomerFavorite.where(provider_id: @provider_id).count
  puts "Tiene: #{@customer_favorited_count}, puede tener 0. (provider_id)(customer_favorites)"
  @overview[:customer_favorited] = @customer_favorited_count

  # Provider Favorites
  @provider_favorite_count = ProviderFavorite.where(provider_id: @provider_id).count
  puts "Tiene: #{@provider_favorite_count}, puede tener 0. (provider_id)(provider_favorites)"
  @overview[:customer_favorites] = @provider_favorite_count

  # Address
  @address_count = Address.where(provider_id: @provider_id).count
  puts "Tiene: #{@address_count}, puede tener 0, debe tener 1. (provider_id)(addresss)"
  @overview[:provider_addresses] = @address_count

  # Business Hours
  @address_id = Address.where(provider_id: @provider_id).first.id
  @business_hours_count = BusinessHour.where(address_id: @address_id).count
  @overview[:business_hours_count] = @business_hours_count

  # Appointments
  @appointments_count = Appointment.where(provider_id: @provider_id).count
  puts "Tiene: #{@appointments_count}, puede tener 0 (provider_id)(appointments)"
  @overview[:appointments_provider_count] = @appointments_count

  # Customer Cards
  @customer_card_count = CustomerCard.where(provider_id: @provider_id).count
  puts "Tiene: #{@customer_card_count}, puede tener 0 (provider_id)(customer_card)"
  @overview[:provider_card_count] = @customer_card_count

  # Medical Profile
  @overview[:medical_profile_count] = MedicalProfile.where(provider_id: @provider_id).count

  # Generic Profile
  @overview[:generic_profile_count] = GenericProfile.where(provider_id: @provider_id).count

  # Invoices Sent
  @overview[:invoices_sent_count] = Invoice.where(provider_id: @provider_id).count
end

def check_customer_associations
  puts "=============== CUSTOMER ID ==================="
  @customer_id = Customer.where(user_id: self.id).first.id
  puts "Customer: (customer_id) #{@customer_id}"

  @overview[:customer_id] =  @customer_id

  # Appointments
  @appointments_count = Appointment.where(customer_id: @customer_id).count
  puts "Tiene: #{@appointments_count}, puede tener 0 (customer_id)(appointments)"
  @overview[:appointments_customer_count] = @appointments_count

  # Customer Cards
  @customer_card_count = CustomerCard.where(customer_id: @customer_id).count
  puts "Tiene: #{@customer_card_count}, puede tener 0 (customer_id)(customer_card)"
  @overview[:customer_card_count] = @customer_card_count

  # Address
  @address_count = CustomerAddress.where(customer_id: @customer_id).count
  puts "Tiene: #{@address_count}, puede tener 0, debe tener 1. (customer_id)(addresss)"
  @overview[:customer_addresses] = @address_count

  # Invoices Received
  @overview[:invoices_received_count] = Invoice.where(customer_id: @customer_id).count
end

def add_anomaly(*messages)
  @anomalies.push(*messages)
end
