class BookingsController < ApplicationController
  def show
    @booking = Booking.find(params[:id])
    @horse = @booking.horse

  end

  def create
    @horse = Horse.find(params[:horse_id])
    @booking = current_user.bookings.new(booking_params)
    @booking.horse = @horse
    @booking.price = booking_price

    if @booking.save
      redirect_to @booking
    else
      render 'horses/show'
    end
  end

  def update
    @booking = Booking.find(params[:id])
    @horse = @booking.horse

    if @booking.update(booking_params)
      redirect_to @booking
    else
      render :show
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date, :horse_id, :user_id, :price, :rating)
  end

  def booking_price
    month_num = (@booking.end_date - @booking.start_date) / 30
    @horse.monthly_price * month_num.to_i
  end
end


