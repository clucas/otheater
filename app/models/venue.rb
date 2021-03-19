class Venue < ApplicationRecord
  has_many :seats, dependent: :delete_all
  has_many :available_seats, -> { where(status: Seat::AVAILABLE_STATUS) }, class_name: 'Seat'

  def self.create_layout(options)
    SeatService.instance.create_layout(options)
  end

  def self.import(file)
    SeatService.instance.import_venue(file)
  end

end
