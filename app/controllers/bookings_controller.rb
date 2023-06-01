class BookingsController < ApplicationController
  # is not necessary to find a book for the booking destroy action
  # the booking destroys itself
  before_action :set_book, only: %i[new create]
  before_action :set_booking, only: %i[accept decline destroy]

  def new
    @booking = Booking.new
  end

  def my_listings
    @my_listings = Booking.where(book: Book.where(user: current_user))
  end

  def my_bookings
    @my_bookings = Booking.where(user: current_user)
  end

  def create
    @booking = Booking.new(listing_params)
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
    redirect_to my_listings_path, status: :see_other
  end

  def decline
    @booking.declined!
    redirect_to my_listings_path, status: :see_other
  end

  def destroy
    @booking.destroy
    redirect_to my_listings_path, status: :see_other
  end

  private

  def set_book
    @book = Book.find(params[:book_id])
  end

  def set_booking
    booking_id = params[:id] || params[:booking_id]

    @booking = Booking.find(booking_id)
  end

  def listing_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end
