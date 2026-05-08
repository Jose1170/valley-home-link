class JobRequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job_request, only: %i[ show edit update destroy accept ]
  before_action :authorize_customer, only: %i[ edit update destroy ]

  # GET /job_requests or /job_requests.json
  def index
    if current_user.customer?
      @job_requests = JobRequest.where(customer_id: current_user.id)
    else
      @job_requests = JobRequest.all
    end

    if params[:service_category_id].present?
      @job_requests = @job_requests.where(service_category_id: params[:service_category_id])
    end
  end

  # GET /job_requests/1 or /job_requests/1.json
  def show
  end

  # GET /job_requests/new
  def new
    @job_request = JobRequest.new
    @job_request.build_address
  end

  # GET /job_requests/1/edit
  def edit
    @job_request.build_address if @job_request.address.nil?
  end

  # POST /job_requests or /job_requests.json
  def create
    @job_request = JobRequest.new(job_request_params)
    @job_request.customer_id = current_user.id

    if @job_request.address.present?
      @job_request.address.user_id = current_user.id
    end

    if @job_request.save
      redirect_to @job_request, notice: "Job request created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /job_requests/1 or /job_requests/1.json
  def update
    if params[:job_request][:address_attributes].present?
      @job_request.build_address unless @job_request.address
      @job_request.address.user_id = current_user.id
    end

    respond_to do |format|
      if @job_request.update(job_request_params)
        format.html { redirect_to @job_request, notice: "Job request was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @job_request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @job_request.errors, status: :unprocessable_entity }
      end
    end
  rescue ArgumentError => e
    redirect_to edit_job_request_path(@job_request), alert: "Invalid status selected. Please choose 0, 1, or 2."
  end

  # DELETE /job_requests/1 or /job_requests/1.json
  def destroy
    @job_request.destroy!

    respond_to do |format|
      format.html { redirect_to job_requests_path, notice: "Job request was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  def accept
    if @job_request.open?
      ActiveRecord::Base.transaction do

        @job_request.update!(job_status: :assigned, provider_id: current_user.id)
        
        @booking = Booking.create!(job_request: @job_request, user: current_user, booking_status: :confirmed
        )
      end
      
      redirect_to edit_booking_path(@booking), notice: "Job Accepted! Please set the meeting schedule."
    else
      redirect_to job_requests_path, alert: "This job has already been taken."
    end
  rescue => e
    redirect_to job_requests_path, alert: "Something went wrong: #{e.message}"
  end

  private
    def set_job_request
      @job_request = JobRequest.find(params[:id])
    end

    def authorize_customer
  return if @job_request.customer_id == current_user.id
  
  if current_user.provider?
    return if action_name == 'accept'
    return if (action_name == 'edit' || action_name == 'update') && @job_request.provider_id == current_user.id
  end

  redirect_to job_requests_path, alert: "You are not authorized to perform this action."
end

    def job_request_params
      params.require(:job_request).permit(
        :job_title, 
        :job_description, 
        :job_status, 
        :service_category_id, 
        address_attributes: [:street_address, :city, :state, :zip_code]
      )
    end
end