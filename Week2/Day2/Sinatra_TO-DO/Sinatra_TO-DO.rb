require 'sinatra'
require 'sinatra/reloader'
require './lib/TaskStorager.rb'
require './lib/Task.rb'
require './lib/UserChecker.rb'

enable :sessions

configure do
	set :users, UserChecker.new
end

get '/' do
	erb :index
end

get '/current_tasks' do
	redirect( to('/') ) if session[:task_file] == nil
	@tasks = TaskStorager.new(session[:task_file]).get_tasks
	erb :current_tasks
end

get '/add_new_task' do
	redirect( to('/') ) if session[:task_file] == nil
	erb :add_new_task
end

get '/completed_tasks' do
	redirect( to('/') ) if session[:task_file] == nil
	@tasks = TaskStorager.new(session[:task_file]).get_tasks
	erb :completed_tasks
end

get '/logout' do
	session[:task_file] = nil
	redirect to '/'
end

post '/add_new_task' do
	current_tasks = TaskStorager.new session[:task_file]
	new_task = Task.new params[:new_task], Time.now.to_i
	current_tasks.add_task new_task
	redirect to '/current_tasks'
end

post '/task_completed' do
	task_id = params[:task].to_i
	current_tasks = TaskStorager.new session[:task_file]
	current_tasks.change_task_status task_id, true
	redirect to "/current_tasks"
end

post '/delete_task' do
	task_id = params[:task].to_i
	current_tasks = TaskStorager.new session[:task_file]
	current_tasks.delete_task task_id
	redirect to '/current_tasks'
end

post '/login' do
	username = params[:username]
	password = params[:password]
	user = settings.users.check_password(username, password)
	unless user == nil
		session[:task_file] = user[:task_file]
		redirect to "/current_tasks"
	else
		@error = "Password does not match"
		erb :index
	end
end
