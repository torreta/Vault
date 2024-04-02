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
		else

			if action_do != nil
				flash.now[:success] = 'Flash sin definir' + action_do
			end
		
		end

	end


end
