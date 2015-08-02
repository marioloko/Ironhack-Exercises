class CitiesController < ApplicationController
	def new
		@city = City.new
	end

	def create
		@city = City.new city_params
		if @city.save
			flash[:notice] = 'City added sucessfully'
		else
			flash[:alert] = 'City not added because is not valid'
		end
		redirect_to new_city_path
	end

	private
	def city_params
		params.require(:city).permit(:name)
	end
end
