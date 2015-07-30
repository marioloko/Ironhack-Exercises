class LinksController < ApplicationController
	def most_visited_pages
		@links = Link.order_URL_by_visited_times
		render 'most_visited_pages'
	end

	def recent_visited_pages
		@links = Link.order_URL_by_last_visit_date
		render 'recent_visited_pages'
	end

	def visit_url
		redirect_to Link.visit_URL_of(params[:shortlink])
	end
end
