class PassengerMailer < ApplicationMailer
  default from: 'bookings@oding-flight-booker.com'

  def confirmation_email
    @passenger = params[:passenger]
    mail(to: @passenger.email, subject: 'Flight Booking Confirmation')
  end
end