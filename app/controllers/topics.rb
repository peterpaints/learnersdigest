# frozen_string_literal: true

helpers do
  def res(status_code, message)
    status status_code
    {
      success: true,
      status: status_code,
      message: message
    }.to_json
  end
end

get '/topics' do
  require_admin
  @topics = Topic.all
  @topic_titles = []
  @topics.each { |topic| @topic_titles << topic.title }
  gon.topic_titles = @topic_titles
  @user = User.first(email: session[:email])
  @digests = @user.userdigests
  erb :topics
end

post '/topics' do
  require_admin
  content_type :json
  @user = User.first(email: session[:email])
  if params[:selected_topics]
    params[:selected_topics].each do |selected_topic|
      topic = Topic.first(title: selected_topic)
      @user.topics << topic
    end
    @user.save
    return res(500, 'Could not save topics.') unless @user.saved?
    Digest.create_digests(@user) if @user.userdigests.empty?
    res(201, 'Topics saved successfully.')
  elsif @user.topics.empty?
    res(500, 'Surely, you want to learn something?')
  end
end

get '/unfollow/:id' do
  require_admin
  @user = User.first(email: session[:email])
  @topic = Topic.first(id: params[:id])
  @user.topics.delete @topic
  @user.save

  if @user.saved?
    redirect '/topics' if @user.topics.empty?
    redirect '/'
  end
end
