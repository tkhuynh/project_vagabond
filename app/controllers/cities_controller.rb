class CitiesController < ApplicationController

	def index
		@cities = City.all
		respond_to do |format|
	 		format.html{render :index}
	 		format.json{render json: @cities}
	 	end
	end

  def show
  	@city = City.friendly.find(params[:id])
  end

private
  def city_params
  	params.require(:city).permit(:name, :long, :lat, :slug)
  end

  def find_city
  	@city = City.friendly.find(params[:id])
  end
end
