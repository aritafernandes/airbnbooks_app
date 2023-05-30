class BookingsController < ApplicationController
  before_action :set_book, only: %i[new create destroy]
  before_action :set_booking, only: %i[accept decline]

  def new
    @booking = Booking.new
  end

  def my_bookings
    @bookings = Booking.where(user: current_user)
  end

  def create
    @booking = Booking.new(booking_params)
    @booking.book = @book
    @booking.user = current_user
    @booking.status = :pending

    if @booking.save
      redirect_to book_path(@book)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def accept
    @booking.accepted!
    redirect_to my_bookings_path, status: :see_other
  end

  def decline
    @booking.declined!
    redirect_to my_bookings_path, status: :see_other
  end

  def destroy
    @booking.destroy
    redirect_to my_bookings_path, status: :see_other
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_booking
    @booking = Booking.find(params[:booking_id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
