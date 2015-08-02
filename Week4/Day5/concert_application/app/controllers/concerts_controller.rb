class ConcertsController < ApplicationController
	def index
		@today_concerts = Concert.where(date: Date.today)
		@monthly_concerts = Concert.later_concerts_this_month
	end

	def most_popular
		@most_commented_concert = Concert.most_commented
	end

	def home
		redirect_to '/'
	end
	
	def limit_price
		render 'limit_price'
	end

	def avaible
		@price = params[:price]
		@avaible_concerts = Concert.with_price_lower_than @price
	end

	def new
		@concert = Concert.new
	end

	def show
		@concert = Concert.find(params[:id])
		@comment = Comment.new
	end

	def create
		@concert = Concert.new(concert_params)
		if @concert.save
			redirect_to concert_path(@concert.id)
		else
			flash[:alert] = @concert.errors.full_messages
			redirect_to new_concert_path
		end
	end

	private
	def concert_params
		params.require(:concert).permit(:band, :venue, :city_id, :date, :price, :description)
	end
end
