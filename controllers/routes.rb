get '/' do
	if session[:email]
		redirect '/dashboard'
	end
	erb :index
end

get '/dashboard' do
	require_admin
	@user = User.first(:email => session[:email])
	@digests = @user.userdigests.reverse
	@digest = @digests[0]

	erb :dashboard
end

get '/unsubscribe' do
	require_admin
	@user = User.first(:email => session[:email])
	@user.unsubscribed = true
	@user.save

	if @user.saved?
		flash[:success] = "No more emails. You've successfully unsubscribed."
		redirect '/'
	end
end
