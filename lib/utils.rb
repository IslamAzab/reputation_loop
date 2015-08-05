class Utils
  def self.compare_places(business, place)
    place_a    = {address: business.to_query, phone: business.phone}
    place_b = {address: "#{place.try(:name)} #{place.try(:formatted_address)} #{place.try(:formatted_phone_number)}",
                                      phone: Utils.normalize_phone(place.try(:formatted_phone_number))}

    a = Geocoder.search(place_a[:address]).first
    b = Geocoder.search(place_b[:address]).first

    response = {}
    if a && b
      response[:name] = a.address_components.first["short_name"] == b.address_components.first["short_name"]
      response[:street_number] = a.street_number == b.street_number
      response[:street_address] = a.street_address == b.street_address
      response[:postal_code] = a.postal_code == b.postal_code
      response[:country] = a.country_code == b.country_code
      response[:state] = a.state == b.state
      response[:city] = a.city == b.city
      response[:phone] = place_a[:phone] == place_b[:phone]
      response[:address] = place_a[:address] == place_b[:address]
      response[:matching_count] = response.values.select { |e| e }.count
    else
      response[:name] = false
      response[:street_number] = false
      response[:street_address] = false
      response[:postal_code] = false
      response[:country] = false
      response[:state] = false
      response[:city] = false
      response[:phone] = false
      response[:address] = false
      response[:matching_count] = 0
    end

    response
  end

  def self.normalize_phone(phone)
    return "" if phone.nil?

    # should we set country code?
    p = Phoner::Phone.parse(phone, :country_code => '385', :area_code => '47')
    if p
      phone = p.format(:us)
    else
      # if phoner can't parse normalize it by removing non digits
      phone = phone.gsub(/\D/, '')
    end    
  end
end