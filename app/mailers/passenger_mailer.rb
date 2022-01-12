class PassengerMailer < ApplicationMailer
  def confirmation_email
    @passenger = params[:passenger]
  end
end
