class CitiesController < ApplicationController
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
