class FlightsController < ApplicationController
  def index
    @flights = Flight.all

    filter_flights unless search_params.empty?
  end

  private

  def search_params
    # add number of passengers later :number_of_passengers 
    if params[:filter]
      params.require(:filter).permit(:departure_airport_id, :arrival_airport_id, :start).compact_blank
    else
      {}
    end
  end

  def filter_flights
    # got the idea here https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
    search_params.each do |k, v|
      @flights = @flights.where(k => v)
    end
  end
end
