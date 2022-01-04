class FlightsController < ApplicationController
  def index
    @flights = Flight.all
    @filters = store_filters

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
      start_date = case time_unit
                   when 'year' then DateTime.new(time.to_i)
                   when 'month' then DateTime.new(search_params[:start][:year].to_i, search_params[:start][:month].to_i)
                   when 'day' 
                    if params[:filter][:start][:month] == ''
                      DateTime.new(search_params[:start][:year].to_i)
                    else
                      DateTime.new(search_params[:start][:year].to_i, search_params[:start][:month].to_i, time.to_i)
                    end
                   end

      end_date = case time_unit
                 when 'year' then start_date.end_of_year
                 when 'month' then start_date.end_of_month
                 when 'day' 
                  if params[:filter][:start][:month] == ''
                    start_date.end_of_year
                  else
                    start_date.end_of_day
                  end
                 end

      @flights = @flights.where('start >= ? AND start <= ?', start_date, end_date)
    end
  end

  def store_filters
    {
      departure_airport: has_filters? && params[:filter][:departure_airport_id],
      arrival_airport_id: has_filters? && params[:filter][:arrival_airport_id],
      year: has_filters? && params[:filter][:start][:year],
      month: has_filters? && params[:filter][:start][:month],
      day: has_filters? && params[:filter][:start][:day]
    }
  end

  def has_filters?
    !params[:filter].nil?
  end
end
