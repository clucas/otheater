require 'json'

class SeatService
  include Singleton

  def import_venue(config)
    results = parse(config)
    venue = Venue.create(results.dig(:venue, :layout).merge({ name: "venue #{rand(1000)}" }))
    seat_map = results[:seats]
    seat_map.keys.each do |s|
      seat_info = {
          guid: seat_map[s][:id].downcase,
          row: seat_map[s][:row].downcase,
          column: seat_map[s][:column],
          status: seat_map[s][:status]
      }
      venue.seats.create(seat_info)
    end
    venue
  end

  def find_seats(seats_number, venue)
    row = 0
    seats_set = []
    seats = available_contiguous_seats(venue)
    if seats_number <= seats[:max]
      seats[:rows].keys.each do |r|
        if seats[:rows][r][:max] >= seats_number
          row = r
          seats_set = seats[:rows][r][:seats].select {|x| x.size >= seats_number }
          seats_set
          break
        end
      end
    end
    priorities_set = []
    seats_set.each do |seats|
      priorities = {}
      seats.each do |seat|
        if seat <= venue.columns/2
          priority = venue.columns - 2 * seat + 1
        else
          priority = 2 * seat - venue.columns
        end
        priorities[priority.to_s.to_sym] = seat
      end
      priorities_set << priorities
    end
    array = priorities_set.collect{ |l| l.keys.map(&:to_s).map(&:to_i).min}
    selection_seats = priorities_set[array.rindex(array.min)]
    all_seats = selection_seats.keys.sort.first(seats_number).collect{|s| "#{row}#{selection_seats[s]}" }
    Seat.where(guid: all_seats)
  end

  private

  def available_contiguous_seats(venue)
    seat_list = venue.available_seats.map(&:guid).sort
    venue_hash = {}
    (1..venue.rows).each do |r|
      row = (96 + r).chr
      row_list = seat_list.select { |x| x.include?(row) }
      venue_hash[row.to_sym] = row_list
    end
    contiguous_seats = { rows: {} }
    venue_hash.keys.each do |row|
      contiguous_seats[:rows][row] = { seats: venue_hash[row].collect { |x| x[1].to_i }.slice_when{|prev,cur| cur != prev + 1}.to_a }
      contiguous_seats[:rows][row][:max] = contiguous_seats[:rows][row][:seats].collect{|x| x.size }.max.to_i
    end
    contiguous_seats[:max] = contiguous_seats[:rows].keys.collect{ |row| contiguous_seats[:rows][row][:max] }.max
    contiguous_seats
  end

  def parse(config)
    JSON.parse(File.read(config.path)).deep_symbolize_keys
  end
end