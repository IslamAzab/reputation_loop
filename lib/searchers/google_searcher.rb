module Searchers
  class GoogleSearcher < BaseSearcher
    attr_reader :client, :place

    def initialize
      @client = GooglePlaces::Client.new(APP_BOX['api_keys']['google_api_key'])
    end

    def place(business)
      # get all details to get full address
      places_details = self.all_places(business).map do |place|
        @client.spot(place.place_id)
      end

      @place = best_matching_place(business, places_details)
    end
    
    def reviews
      @place.reviews
    end

    protected
    def all_places(business)
      @client.spots_by_query(business.to_query)
    end

  end
end