class BookingsController < ApplicationController
  # is not necessary to find a book for the booking destroy action
  # the booking destroys itself
  before_action :set_book, only: %i[new create]
  before_action :set_booking, only: %i[accept decline destroy]

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
      redirect_to my_bookings_path
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
    # changed the params to params[:id], referencing itself
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
