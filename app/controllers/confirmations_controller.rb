class ConfirmationsController < ApplicationController

  # GET /request/confirmations/new
  def new
    @request = Request.new
  end

  # POST /request/confirmations
  def create
    @request = Request.resend_confirmation_instructions(params[:request][:email])
    if @request.errors.empty?
      redirect_to root_path()
    else
      render :new
    end
  end

  # GET /request/confirmations/confirmation?confirmation_token=abcdef
  def confirmation
    @request = Request.confirm_by_token(params[:confirmation_token])
    if @request.errors.empty?
      flash[:notice] = "Email confirmer avec succes"
      redirect_to root_path()
    else
      render :new
    end
  end
end
