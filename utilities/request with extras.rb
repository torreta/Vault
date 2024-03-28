module ApplicationHelper

	require 'net/http'
	require 'uri'


	# Performs an HTTP call using the specified HTTP method, URL,  headers, and body
	def httpCall(httpMethod, url, header, body)
		uri = URI(url)
		
		case httpMethod
		when 'Get'
			request = Net::HTTP::Get.new(uri, header)
		when 'Post'
			request = Net::HTTP::Post.new(uri, header)
		when 'Put'
			request = Net::HTTP::Put.new(uri, header)
		when 'Delete'
			request = Net::HTTP::Delete.new(uri, header)
		end
					
		# los unicos metodos que envian datos necesito enviarlos en formato json
		if httpMethod == 'Post' || httpMethod == 'Put'
			request.body = body.to_json
		end

		# logger.debug "=========FULL SERVER REQUEST========="
		# logger.debug  request.to_json
		# logger.debug "=========FULL SERVER REQUEST END========="

		
		# Perform the HTTP request using the specified hostname and port
		# Parse the response body as JSON
		begin

			response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
				http.request(request)
			end

			logger.debug "=========RESPONSE STATUS========="
			logger.debug response.code
			# logger.debug "=========RESPONSE STATUS END========="

			# sino me response dentro de las respuestas esperadas, levanto un error
			# pues resulta que los types eran string
			if !["200", "201", "202"].include?(response.code)
				raise StandardError,  "Unknown error: #{response.code}"
			end

			# lo que retorno lo parseo para usarlo en los controladores
			@server_response = JSON.parse(response.body, symbolize_names: true)

			logger.debug "=========FULL SERVER RESPONSE========="
			logger.debug response
			logger.debug response.body
			logger.debug "=========FULL SERVER RESPONSE END========="

			return @server_response

		rescue StandardError => e

			# Log the error, return nil, or handle as appropriate
			logger.debug "HTTP Call failed: #{e.message}"

			# aqui deberia poner que hacer en todas las excepciones
			# ejemplo que hacer cuando hay unauthorized handlers?
			# envio un mensaje segun el caso del code
			flash_message_http_error(response.code) 

			return nil

		rescue Net::HTTPExceptions => e

			logger.debug "HTTPExceptions"
			flash.now[:error] = 'Errores de Comunicacion con el servidor'

			return nil

		rescue JSON::ParserError => e
			
			logger.debug "JSON::ParserError"
			flash.now[:error] = 'Problemas con el formato de la respuesta del servidor'
			return nil

		end

	end

	# Flash message for HTTP errors 
	def flash_message_http_error(code)
		
		@code = code.to_i

		case @code
		when 400
			# Handle bad request error
			logger.debug "HTTPBadRequest"
			flash.now[:error] = 'Datos Incorrectos'
		when 401
			# Handle unauthorized error
			logger.debug "HTTPUnauthorized"
			flash.now[:error] = 'Su Session esta Vencida'
		when 403
			# Handle forbidden error
			logger.debug "HTTPForbidden"
			flash.now[:error] = 'No tiene permisos para realizar esta accion'
		when 404
			# Handle not found error
			logger.debug "HTTPNotFound"
			flash.now[:error] = 'Pagina no encontrada'
		when 405
			# Handle method not allowed error
			logger.debug "HTTPMethodNotAllowed"
			flash.now[:error] = 'Metodo no permitido'
		when 408
			# Handle request timeout error
			logger.debug "HTTPRequestTimeout"
			flash.now[:error] = 'Tiempo de espera excedido'
		when 413
			# Handle request entity too large error
			logger.debug "HTTPRequestEntityTooLarge"
				flash.now[:error] = 'Peticion Demasiado Largaa'
		when 415
			# Handle unsupported media type error
			logger.debug "HTTPUnsupportedMediaType"
			flash.now[:error] ='Formato no Permitido'
		when 500
			# Handle internal server error
			logger.debug "HTTPInternalServerError"
			flash.now[:error] = 'Error Interno del Servidor'
		when 501
			# Handle not implemented error
			logger.debug "HTTPNotImplemented"
			flash.now[:error] = 'Metodo no Implementado'
		when 502
			# Handle bad gateway error
			logger.debug "HTTPBadGateway"
			flash.now[:error] = 'Error de Gateway'
		when 503
			# Handle unsupported media type error
			logger.debug "HTTPUnsupportedMediaType"
			flash.now[:error] ='Formato no Permitido'
		when 504
			# Handle gateway timeout error
			logger.debug "HTTPGatewayTimeout"
			flash.now[:error] = 'Error de Timeout de Gateway'
		when 505
			# Handle HTTP version not supported error
			logger.debug "HTTPVersionNotSupported"
			flash.now[:error] = 'Version de HTTP no Soportada'
		when 507		
			# Handle internal server error
			logger.debug "HTTPInternalServerError"
			flash.now[:error] = 'Error Interno del Servidor'
		else

			# Handle internal server error
			logger.debug "HTTPInternalServerError"
			flash.now[:error] = 'GRAVE! ERROR NO MANEJADO'

			logger.debug "=========AVISO, ESTE CASO DE HTTP ERROR NO LO ESTOY MANEJANDO========="
			logger.debug code
			logger.debug "=========AVISO, ESTE CASO DE HTTP ERROR NO LO ESTOY MANEJANDO END========="
		end

	end

  def works_here?
		return true
	end

end
