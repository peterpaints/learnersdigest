# frozen_string_literal: true

get '/' do
  redirect '/dashboard' if authorized?
  erb :index
end

get '/dashboard' do
  @reading_lists = @user.reading_lists.reverse

  erb :dashboard
end

post '/dashboard' do
  @articles = @user.reading_lists.reverse.map do |reading_list|
    reading_list.articles.select do |article|
      article.title =~ /#{params[:query]}/i
    end
  end
  @reading_lists = @user.reading_lists.reverse.reject do |reading_list|
    (reading_list.articles & @articles.flatten).empty?
  end

  erb :dashboard
end

get '/unsubscribe' do
  @user.unsubscribed = !@user.unsubscribed

  if @user.save
    flash[:success] = "Great! You've successfully changed subscription status."
    redirect '/'
  end
end
