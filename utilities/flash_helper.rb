module FlashHelper

	
	def flash_helper(action_do = null)
		# aqui todos los mensajes flash de la aplicacion cuando se hacen acciones o mensajes al usuario

		case action_do
		# los casos...
		when 'successful_login'
			flash.now[:success] = 'Bienvenido de nuevo ' + @current_user[:user][:email]
		when 'successful_register'
			flash.now[:success] = 'Registro de perfil exitoso ' + @current_user[:user][:email]
		when 'successful_update'
			flash.now[:success] = 'Datos actualizados correctamente'
		when 'successful_login'
			flash.now[:success] = 'Bienvenido de nuevo ' + @current_user[:user][:email]
		when 'successful_register'
			flash.now[:success] = 'Registro de perfil exitoso ' + @current_user[:user][:email]
		when 'successful_medical_register'
			flash.now[:success] = 'Registro de perfil médico exitoso ' + @current_user[:user][:email]
			flash.now[:success] = 'Datos actualizados correctamente'
		when 'Registro_Correcto'
			flash.now[:success] = 'Se suscribio correctamente al plan '	
			flash.now[:success] = 'Registro de perfil de servicios varios exitoso '
		when 'Fallo_cus'
			flash.now[:error] = 'Usted no posee cuenta cliente'
		when 'Medical_error'
			flash.now[:error] = 'Usted no posee cuenta de Medico'
		when 'Generic_error'
			flash.now[:error] = 'Usted no posee cuenta Servicios Varios '
		when 'successful_update_medical_profile'
			flash.now[:success] = 'Datos actualizados correctamente'
		else

			if action_do != nil
				flash.now[:success] = 'Flash sin definir' + action_do
			end
		
		end

	end

end