def httpCall(httpMethod, url, header, body)
  uri = URI(url)
  
  case httpMethod
  when 'Get'
    request = Net::HTTP::Get.new(uri, header)
  when 'Post'
    request = Net::HTTP::Post.new(uri, header)
    request.body = body.to_json
  when 'Put'
    request = Net::HTTP::Put.new(uri, header)
    request.body = body.to_json
  when 'Delete'
    request = Net::HTTP::Delete.new(uri, header)
  end

        
  logger.debug "=========FULL SERVER REQUEST========="
  logger.debug  request.to_json
  logger.debug "=========FULL SERVER REQUEST END========="

  
  # Perform the HTTP request using the specified hostname and port
  # Parse the response body as JSON
  begin
    response = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      http.request(request)
    end

    # lo que retorno
    @server_response = JSON.parse(response.body, symbolize_names: true)
    
    logger.debug "=========FULL SERVER RESPONSE========="
    logger.debug response
    logger.debug "=========FULL SERVER RESPONSE END========="

    return @server_response

  rescue Net::HTTPExceptions, JSON::ParserError => e
    # Log the error, return nil, or handle as appropriate
    puts "HTTP Call failed: #{e.message}"
    logger.debug "HTTP Call failed: #{e.message}"

    # aqui deberia poner que hacer en todas las excepciones
    # ejemplo que hacer cuando hay unauthorized handlers?

    return nil
  end

end