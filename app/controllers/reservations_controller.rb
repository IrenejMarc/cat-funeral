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

    @reservation.year = @reservation.starts_at.year
    @reservation.month = @reservation.starts_at.month
    @reservation.day = @reservation.starts_at.day
    @reservation.ends_at = @reservation.starts_at + 2.hours

    cnt = Reservation.where('starts_at >= ? AND ends_at <= ?', @reservation.starts_at, @reservation.starts_at).count
    if cnt > 0
      @error = 'A booking already exists at this time, please select another time'
      render :new
      return
    end

    if @reservation.save
      redirect_to reservation_path(@reservation)
    else
      render :new
    end
  end

  def day
    require 'open_weather'
    weather_options = {
        units: 'metric',
        APPID: 'd35081c3cc9de6d307a107a9651a7313'
    }

    @date = Date.parse params[:day]
    @reservations = Reservation.where year: @date.year, month: @date.month, day: @date.day

    @weather = nil
    weather = OpenWeather::ForecastDaily.city_id 3196359, weather_options

    weather['list'].each do |day|
      dt = Time.at(day['dt']).to_datetime

      str = dt.strftime '%Y-%m-%d'
      if str == @date.strftime('%Y-%m-%d')
        @weather = day
        break
      end
    end

  end

  private
    def reservation_params
      params.require(:reservation).permit(:name, :year, :month, :day, :starts_at)
    end
end
