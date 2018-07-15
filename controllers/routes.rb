get '/' do
	if session[:email]
		redirect '/dashboard'
	end
	erb :index
end

get '/topics' do
	require_admin
	@topics = Topic.all
	@topic_titles = []
	@topics.each { |topic| @topic_titles << topic.title }
	gon.topic_titles = @topic_titles
	@user = User.first(:email => session[:email])
	@digests = @user.userdigests
	erb :topics
end

get '/dashboard' do
	require_admin
	@user = User.first(:email => session[:email])
	@digests = @user.userdigests.reverse
	@digest = @digests[0]

	erb :dashboard
end
