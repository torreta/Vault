def sanitize_params(bh_params)
  # im doing this because i dont want to
  # have an invalid start time or end time

  logger.debug "SANITIZE ON"
  logger.debug bh_params.to_json
  logger.debug "self?"
  logger.debug self.to_json

  @bh = self

  if @bh.hour_start.nil?
    @bh.hour_start = DateTime.now.change(hour: 7, min: 0, sec: 0)
    @bh.save
  end

  if @bh.hour_finish.nil?
    @bh.hour_start = DateTime.now.change(hour: 7, min: 0, sec: 0)
    @bh.save
  end

  # si me pasas null, necesito que lo deje igual

  # example
  # {"address_id":99,"hour_start":null,"hour_finish":null,"appointment_duration":"25","name":"clinica 1","monday":"0","tuesday":"1","wednesday":"0","thursday":"0","friday":"0","saturday":"0","sunday":"0"}

  # si me pasas null, necesito que lo deje igual
  if bh_params && bh_params['hour_start'].nil? 
    bh_params['hour_start'] = @bh.hour_start 
  end

  # si me pasas null, necesito que lo deje igual
  if bh_params && bh_params['hour_start'] == "null"
    bh_params['hour_start'] = @bh.hour_start
  end

  # si me pasas null, necesito que quede igual
  if bh_params && bh_params['hour_finish'].nil? 
    bh_params['hour_finish'] = @bh.hour_finish
  end
  # si me pasas null, necesito que quede igual
  if bh_params && bh_params['hour_finish'] == "null"
    bh_params['hour_finish'] = @bh.hour_finish 
  end

  bh_params

end