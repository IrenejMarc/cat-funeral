require 'date'

class ReservationsController < ApplicationController
  def index
    month = Date.today.strftime '%m'
    @reservations = Reservation.where month: month
    @weathers
  end

  def show
    @reservation = Reservation.find params[:id]
  end

  def new
    authorize

    @reservation = Reservation.new
    @reservation.starts_at = params[:date]
  end

  def create
    authorize

    @reservation = Reservation.new reservation_params
    @reservation.user = current_user

    # Move to initializer? after_initialize?
    @reservation.year = @reservation.starts_at.year
    @reservation.month = @reservation.starts_at.month
    @reservation.day = @reservation.starts_at.day
    @reservation.ends_at = @reservation.starts_at + 2.hours

    if @reservation.save
      redirect_to reservation_path(@reservation)
    else
      render :new
    end
  end

  def day
    @date = Date.parse params[:day]
    @reservations = Reservation.where(year: @date.year, month: @date.month, day: @date.day).order :starts_at
    @weather = FetchWeather.for_day @date
  end

  private
    def reservation_params
      params.require(:reservation).permit(:name, :year, :month, :day, :starts_at)
    end
end
