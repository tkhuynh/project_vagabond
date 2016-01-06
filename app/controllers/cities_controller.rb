class CitiesController < ApplicationController

	def index
		@cities = City.all
		respond_to do |format|
	 		format.html{render :index}
	 		format.json{render json: @cities}
	 	end
	end

  def show
  	@city = City.find(params[:id])
  end
end
