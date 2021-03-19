class ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[ show edit update destroy ]

  # GET /reservations or /reservations.json
  def index
    @reservations = Reservation.includes(:movie, :seats).all
  end

  # GET /reservations/1 or /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @movie = Movie.find(params[:movie_id])
    @venues = Venue.all
    @reservation = Reservation.new(movie_id: params[:movie_id])
  end

  # GET /reservations/1/edit
  def edit
  end

  # POST /reservations or /reservations.json
  def create
    begin
      @reservation = Reservation.find_seats(reservation_params)
    rescue StandardError => e
      Rails.logger.error(e.message)
      Rails.logger.error(e.backtrace.join('\n'))
    end
    if @reservation
      respond_to do |format|
        format.html { redirect_to @reservation, notice: "Reservation was successfully created." }
        format.json { render :show, status: :created, location: @reservation }
      end
    else
      @movie = Movie.find(reservation_params[:movie_id])
      @venues = Venue.all
      @reservation = Reservation.new(name: reservation_params[:name], movie_id: reservation_params[:movie_id], venue_id: reservation_params[:venue_id])
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity, notice: "Not seats available" }
        format.json { render json: { errors: "Not available" }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1 or /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: "Reservation was successfully updated." }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1 or /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: "Reservation was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reservation_params
      params.require(:reservation).permit(:name, :venue_id, :movie_id, :seats_number)
    end
end
