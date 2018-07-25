# frozen_string_literal: true

class PagesController < ApplicationController
  get '/' do
    redirect '/dashboard' if logged_in?

    erb :'pages/index'
  end

  get '/dashboard' do
    @articles = @user.reading_lists.reverse.map do |reading_list|
      reading_list.articles.select do |article|
        article.title =~ /#{params[:q]}/i
      end
    end

    # filter reading_lists by query
    @reading_lists = @user.reading_lists.reverse.reject do |reading_list|
      (reading_list.articles & @articles.flatten).empty?
    end

    if params[:q] && @reading_lists.empty?
      flash.now[:danger] = 'Your search returned no digests with that article.'
    end

    erb :'pages/dashboard'
  end

  get '/toggle_subscription' do
    @user.unsubscribed = !@user.unsubscribed

    if @user.save
      flash[:success] = "Done! You've successfully changed subscription status."
      redirect '/'
    end
  end
end
