class PassengerMailer < ApplicationMailer
  default from: 'bookings@oding-flight-booker.com'

  def confirmation_email
    @passenger = params[:passenger]
    mail(to: email_address_with_name(@passenger.email, @passenger.name),
         subject: 'Flight Booking Confirmation')

    # PassengerMailer.with(passenger: Passenger.first).confirmation_email.deliver_now!
  end
end