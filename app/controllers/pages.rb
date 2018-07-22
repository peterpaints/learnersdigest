# frozen_string_literal: true

get '/' do
  redirect '/dashboard' if authorized?
  erb :index
end

get '/dashboard' do
  @reading_lists = @user.reading_lists.reverse
  @reading_list = @reading_lists.first

  erb :dashboard
end

get '/unsubscribe' do
  @user.unsubscribed = !@user.unsubscribed

  if @user.save
    flash[:success] = "Great! You've successfully changed subscription status."
    redirect '/'
  end
end
