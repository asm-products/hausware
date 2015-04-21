class ReservationMailer < ApplicationMailer
  def created_email(reservation)
    @reservation = reservation
    mail(to: @reservation.email, subject: "Reservation at #{@reservation.space.location.org.name}, #{@reservation.space.location.name} on #{@reservation.starts_at_in_zone.strftime('%D %I:%M %p')}")
  end
  def canceled_email(reservation)
    @reservation = reservation
    mail(to: @reservation.email, subject: "Reservation Canceled - #{@reservation.space.location.org.name}, #{@reservation.space.location.name} on #{@reservation.starts_at_in_zone.strftime('%D %I:%M %p')}")
  end
end
