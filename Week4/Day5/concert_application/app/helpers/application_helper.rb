module ApplicationHelper
	def flash_message
		if flash[:notice]
			flash[:notice]
		elsif flash[:alert]
			flash[:alert]
		end
	end
end
