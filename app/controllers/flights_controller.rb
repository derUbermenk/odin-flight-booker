class FlightsController < ApplicationController
  def index
    @flights = Flight.all

    filter_flights unless search_params.empty?
  end

  private

  def search_params
    # add number of passengers later :number_of_passengers 
    if params[:filter]
      params.require(:filter)
            .permit(:departure_airport_id, :arrival_airport_id, start: %i[year month day])
            .compact_blank
    else
      {}
    end
  end

  def filter_flights
    # got the idea here https://www.justinweiss.com/articles/search-and-filter-rails-models-without-bloating-your-controller/
    search_params.each do |k, v|
      case k
      when 'start'
        filter_flight_dates(v.compact_blank)
      else
        @flights = @flights.where(k => v)
      end
    end
  end

  def filter_flight_dates(date)
    date.each do |time_unit, time|
      case time_unit
      when 'year'
        start_date = DateTime.new(time.to_i)
        end_date = start_date.end_of_year
        @flights = @flights.where('start >= ? AND start <= ?', start_date, end_date)
      when 'month'
        start_date = DateTime.new(search_params[:start][:year].to_i, search_params[:start][:month].to_i)
        end_date = start_date.end_of_month
        @flights = @flights.where('start >= ? AND start <= ?', start_date, end_date)
      when 'day'
        start_date = DateTime.new(search_params[:start][:year].to_i, search_params[:start][:month].to_i, time.to_i)
        end_date = start_date.end_of_day
        @flights = @flights.where('start >= ? AND start <= ?', start_date, end_date)
      end
    end
  end
end
