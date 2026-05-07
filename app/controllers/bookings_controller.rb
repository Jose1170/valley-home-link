class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_booking, only: [:show, :edit, :update]

  def index
    # Providers see jobs they've accepted, Customers see jobs they've booked
    if current_user.provider?
      @bookings = Booking.where(user_id: current_user.id)
    else
      @bookings = Booking.joins(:job_request).where(job_requests: { customer_id: current_user.id })
    end
  end

  def edit
    # This is the page where they pick the time
  end

  def update
    if @booking.update(booking_params)
      redirect_to job_request_path(@booking.job_request), notice: "Schedule confirmed!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_booking
    @booking = Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:scheduled_at, :booking_status)
  end
end