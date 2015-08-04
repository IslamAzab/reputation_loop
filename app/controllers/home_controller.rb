class HomeController < ApplicationController

  def scanner
    if params[:business]
      @business = Business.new(business_params) 
      @business.normalize_phone
      
      searcher = Searcher.new(Searchers::GoogleSearcher)

      @place = searcher.place(@business)
      if @place
        address_input_from_user    = {address: @business.to_query, phone: @business.phone}
        address_from_google_places = {address: "#{@place.try(:name)} #{@place.try(:formatted_address)} #{@place.try(:formatted_phone_number)}",
                                      phone: Utils.normalize_phone(@place.try(:formatted_phone_number))}
  # byebug

        @comparison_result = Utils.compare_places(address_input_from_user, address_from_google_places)
      end
    end
  end

  private
  def business_params
    params.require(:business).permit(:name, :address, :city, :state, :zip, :phone)
  end
end
