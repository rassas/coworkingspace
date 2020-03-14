class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = CoworkingSpace.last.requests.new(request_params)
    @request.save
    redirect_to root_path
  end

  private

  def request_params
    params.require(:request).permit(:name, :phone, :email, :biography)
  end
end
