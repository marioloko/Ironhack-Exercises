class NewFile
	def enter_new_file_name new_file_name
		puts "Please, enter the new file name"
		@new_file_name = new_file_name
	end

	def creating_new_file
		IO.write(@new_file_name, "")
	end

	def write_file message
		IO.write(@new_file_name, message)
	end

	def close_file 
		IO.close(@new_file_name)
	end
end


