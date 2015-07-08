class TextParser
	def initialize file_name
		@file_name = file_name
		@separator = "----"
	end
	
	def get_slides slide, separator
		IO.readlines(@file_name, separator)
	end

	def remove_line_separator line, separator
		line = line.delete separator
	end

	def get_slides_without_separator
		get_slides(@file_name, @separator).each do |line|
			line.delete! @separator
		end
	end
end	

class FilePrinter
	require 'terminfo'
	def initialize file_name
		@file_name = file_name
		@current_slide = 0
		@terminal_size = TermInfo.screen_size
	end

	def adjust_heigh
		half_height = (@terminal_size[0] / 2) - 1
		for times in 1..half_height 
			puts ""
		end
	end

	def multilines_centering message
		lines = message.split("\n")
		centered_lines = ""
		lines.each do |line|
			centered_lines += adjust_message_to_width line
		end
		centered_lines
	end

	def adjust_message_to_width message
		message.strip.center @terminal_size[1]
	end

	def show_slide number
		file_parser = TextParser.new(@file_name)
		slide = file_parser.get_slides_without_separator[number]
		adjust_heigh
		puts multilines_centering slide 
		adjust_heigh
	end
end

class KeyNote
	def initialize file_name
		@file_name = file_name
		@file_printer = FilePrinter.new(file_name)
		@current_slide = 0
		@number_of_slides = TextParser.new(file_name).get_slides_without_separator.count
	end

	def do_action action
		case action
			when "next"
				go_next
			when "previous"
				go_previous
			when "exit"
				exit_program
			when "auto"
				go_auto 3
		end
	end

	def go_next
		if (@current_slide < @number_of_slides - 1)
			@current_slide += 1
		end
	end

	def go_auto seconds
		@current_slide = 0
		while (@current_slide < @number_of_slides - 1)
			@file_printer.show_slide @current_slide
			go_next
			sleep seconds
		end
	end

	def go_previous
		if (@current_slide > 0)
			@current_slide -= 1
		end
	end

	def exit_program
		@current_slide = -1
	end

	def get_input_from_prompt
		print ">"
		action = gets.chomp
	end
	
	def run_presentation
		while @current_slide >= 0
			@file_printer.show_slide @current_slide
			action = get_input_from_prompt
			do_action action
		end
	end
end

KeyNote.new("slides.txt").run_presentation
