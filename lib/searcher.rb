class Searcher

  AVAILABLE_SEARCHERS = [Searchers::GoogleSearcher]

  attr_reader :performer

  def initialize(searcher_name)
    @performer = searcher_name.new
  end

  def place(business)
    @performer.place(business)
  end

  def reviews
    @performer.reviews
  end
end