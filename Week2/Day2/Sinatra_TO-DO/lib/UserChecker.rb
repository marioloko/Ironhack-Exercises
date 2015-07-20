class UserChecker
	def initialize
		@file = './user.txt'
		@users = []
		load_users
	end

	def load_users
		users_data = IO.read(@file).split("\n")
		users_data.each do |user|
			user_data = user.split(" ")
			@users << create_user_from_data(user_data)
		end
	end
	
	def create_user_from_data user_data
		new_user = {}
		new_user[:username] = user_data[0]
		new_user[:password] = user_data[1]
		new_user[:task_file] = user_task_file new_user[:username]
		new_user
	end

	def user_task_file username
		"./public/#{username}.txt"
	end

	def check_password username, password
		current_users = @users.select do |user|
			user[:username] == username && user[:password] == password
		end
		current_users.first
	end
end
