# require 'lib/utils'
class Business < ActiveRecord::Base
  def normalize_phone
    self.phone = Utils.normalize_phone(self.phone)
  end

  def to_query
    atts = [self.name, self.address, self.city, self.state, self.zip, self.phone]
    atts.reject!(&:blank?)
    atts.join(" ")
  end
end
