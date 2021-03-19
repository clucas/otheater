class Seat < ApplicationRecord
  belongs_to :venue
  belongs_to :reservation

  AVAILABLE_STATUS = 'AVAILABLE'
  RESERVED_STATUS = 'RESERVED'

  def book
    self.update_columns(status: RESERVED_STATUS)
  end
end
