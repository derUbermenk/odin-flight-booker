class BookingsController < ApplicationController
  def new
    @booking = Booking.new
    @booking.flight = Flight.find(new_params[:flight_id])

    new_params[:number_of_passengers].times { @booking.passengers.build }
  end

  def create
    @flight = Flight.find(params[:booking][:flight_id])
    @booking = @flight.bookings.build(create_params)

    if @booking.save
      @booking.send_confirmation
      render :show
    else
      flash[:error] = 'Failed Booking flight'
      render :new
    end
  end

  private

  def create_params
    params.require(:booking)
          .permit(passengers_attributes: %i[name email])
  end

  def new_params
    params.require(:booking)
          .permit(:flight_id, :number_of_passengers)
          .transform_values(&:to_i)
  end
end
