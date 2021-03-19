class Reservation < ApplicationRecord
  belongs_to :venue
  belongs_to :movie
  has_many :seats

  def self.find_seats(options)
    reservation = nil
    ActiveRecord::Base.transaction do
      begin
        venue = Venue.find(options[:venue_id])
        available_seats = SeatService.instance.find_seats(options[:seats_number].to_i, venue)
        booked = []
        if available_seats.any?
          booked = available_seats.collect do |seat|
            seat.book
            seat
          end
        end
        if booked.any?
          reservation = Reservation.create(name: options[:name], venue_id: options[:venue_id], movie_id: options[:movie_id], seats: booked)
        end
      rescue StandardError => e
        Rails.logger.error e.message
        Rails.logger.error e.backtrace.join('\n')
      end
    end
    reservation
  end
end
