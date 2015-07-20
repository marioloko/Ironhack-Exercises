require 'pry'
class Task
	attr_reader :content, :id, :status
	def initialize content, id
		@content = content
		@id = id
		@status = false
	end

	def set_status status
		@status = status
	end

	def to_s
		@content.to_s + " " + @id.to_s + " " + @status.to_s 
	end

	def self.create_task_from_string string_with_parameters
		parameters = string_with_parameters.split(" ")
		content = parameters[0]
		id = parameters[1].to_i
		status = parameters[2] == "true"
		task = Task.new(content, id)
		task.set_status(status)
		task
	end
end
