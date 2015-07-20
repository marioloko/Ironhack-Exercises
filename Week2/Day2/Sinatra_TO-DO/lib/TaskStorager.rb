require './lib/Task.rb'
require 'pry'

class TaskStorager
	def initialize file
		@file = file
	end

	def get_tasks
		tasks_parameters = IO.read(@file).split("\n")
		get_tasks_from_parameters tasks_parameters
	end

	def get_tasks_from_parameters tasks_parameters
		tasks = []
		tasks_parameters.each do |task_parameters|
			tasks << Task.create_task_from_string(task_parameters)
		end
		tasks
	end

	def add_task task
		memory = File.open(@file,"a")
		memory.puts(task.to_s)
		memory.close
	end
	
	def delete_task task_id
		tasks = get_tasks
		tasks.delete_if { |task| task.id == task_id }
		add_all_task tasks
	end

	def add_all_task tasks
		delete_file_content
		tasks.each { |task| add_task task }
	end

	def change_task_status task_id, new_status
		tasks = get_tasks
		tasks.each { |task| task.set_status(new_status) if task.id == task_id }
		add_all_task tasks
	end

	def find_id task_id
		desired_task = get_tasks.select do |task|
			task.id == task_id
		end
		desired_task.first
	end

	def delete_file_content
		File.open(@file, "w") {}
	end
end
