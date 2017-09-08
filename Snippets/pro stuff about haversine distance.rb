
  def distance(destination={})


    if !destination[:latitude].present? || !destination[:longitude].present?
      return nil
    end

    distance_haversine([latitude.to_f,longitude.to_f], [destination[:latitude].to_f, destination[:longitude].to_f])

  end

  def distance_to(destination)

    distance_haversine([latitude,longitude], destination)

  end

  def distance_haversine(loc1, loc2)

    # Haversine formula
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    # Delta to radians
    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg


    # Points to radians
    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }


    # Formula
    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    # Distance in meters
    rm * c # Delta in meters

  end

  def self.distance_haversine(loc1, loc2)


    # Haversine formula
    rad_per_deg = Math::PI/180  # PI / 180
    rkm = 6371                  # Earth radius in kilometers
    rm = rkm * 1000             # Radius in meters

    # Delta to radians
    dlat_rad = (loc2[0]-loc1[0]) * rad_per_deg  # Delta, converted to rad
    dlon_rad = (loc2[1]-loc1[1]) * rad_per_deg

    # Points to radians
    lat1_rad, lon1_rad = loc1.map {|i| i * rad_per_deg }
    lat2_rad, lon2_rad = loc2.map {|i| i * rad_per_deg }


    # Formula
    a = Math.sin(dlat_rad/2)**2 + Math.cos(lat1_rad) * Math.cos(lat2_rad) * Math.sin(dlon_rad/2)**2
    c = 2 * Math::atan2(Math::sqrt(a), Math::sqrt(1-a))

    # Distance in meters
    rm * c # Delta in meters

  end

  def distance_geocoder(destination={})

     if !destination[:latitude].present? || !destination[:longitude].present?
       return nil
     end

     coords = destination[:latitude] + "," + destination[:longitude]
     from = Geokit::Geocoders::GoogleGeocoder.reverse_geocode latitude + "," + longitude
     to = Geokit::Geocoders::GoogleGeocoder.reverse_geocode coords

     from.distance_to(to)
  end
