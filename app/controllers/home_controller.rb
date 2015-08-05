class HomeController < ApplicationController

  def scanner
    # make sure any value exists for search
    if !params["business"].values.reject(&:empty?).count.zero?
      @business = Business.new(business_params) 
      @business.normalize_phone

      # scrap matching place
      searcher = Searcher.new(Searchers::GoogleSearcher)
      @place = searcher.place(@business)
      
      @comparison_result = Utils.compare_places(@business, @place) if @place
    end
  end

  private
  def business_params
    params.require(:business).permit(:name, :address, :city, :state, :zip, :phone)
  end
end
