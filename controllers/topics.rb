post '/topics' do
	require_admin
	content_type :json
	@user = User.first(:email => session[:email])
	if params[:selected_topics]
		params[:selected_topics].each do |selected_topic|
			topic = Topic.first(:title => selected_topic)
			@user.topics << topic
		end

		@user.save
		if @user.saved?
			Digest.create_digests @user unless !@user.userdigests.empty?
			status 201
			{
				success: true,
				status: 201,
			}.to_json
		else
			status 500
			{
				error: true,
				status: 500,
				message: 'Could not save topics. Please try again.'
			}.to_json
		end
	else
		if @user.topics.empty?
			status 500
			{
				error: true,
				status: 500,
				message: 'Surely, you want to learn something?'
			}.to_json
		end
	end
end
