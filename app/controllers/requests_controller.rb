class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = CoworkingSpace.last.requests.new(request_params)
    if @request.save
      flash[:notice] = "Votre demande à été envoyé. Vous devez confirmer votre e-mail pour rejoindre la liste d'attente."
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def request_params
    params.require(:request).permit(:name, :phone, :email, :biography)
  end
end
