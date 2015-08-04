class Utils
  def self.compare_places(place_a, place_b)
     a = Geocoder.search(place_a[:address]).first
     b = Geocoder.search(place_b[:address]).first

     response = {}
     if b
       response[:street_number] = a.street_number == b.street_number
       response[:street_address] = a.street_address == b.street_address
       response[:postal_code] = a.postal_code == b.postal_code
       response[:country] = a.country_code == b.country_code
       response[:state] = a.state == b.state
       response[:city] = a.city == b.city
       response[:phone] = place_a[:phone] == place_b[:phone]
       response[:matching_count] = response.values.keep_if { |e| e }.count
     else
       response[:street_number] = false
       response[:street_address] = false
       response[:postal_code] = false
       response[:country] = false
       response[:state] = false
       response[:city] = false
       response[:phone] = false
       response[:matching_count] = 0
     end

     response
  end

  def self.normalize_phone(phone)
    return "" if phone.nil?
    p = Phoner::Phone.parse(phone, :country_code => '385', :area_code => '47')
    if p
      phone = p.format(:us)
    else
      phone = phone.gsub(/\D/, '')
    end    
  end
end