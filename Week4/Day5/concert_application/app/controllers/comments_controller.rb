class CommentsController < ApplicationController
	def create
		@concert = Concert.find(params[:id])
		@comment = @concert.comments.new(comment_params)
		if @comment.save
			flash[:notice] = 'Comment send succesfully'
		else
			flash[:alert] = 'The comment cannot be send, it is not correct'
		end	
		redirect_to concert_path(@concert.id)
	end

	private
	def comment_params
		params.require(:comment).permit(:title, :body)
	end
end
