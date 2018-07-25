# frozen_string_literal: true

class TopicsController < ApplicationController
  get '/topics' do
    @topics = Topic.all
    gon.topic_titles = @topics.map(&:title)
    gon.user_topics = @user.topics.map(&:title) unless @user.topics.empty?
    @reading_lists = @user.reading_lists

    erb :'pages/topics'
  end

  post '/topics' do
    content_type :json
    if params[:selected_topics]
      params[:selected_topics].each do |selected_topic|
        topic = Topic.first(title: selected_topic)
        @user.topics << topic
      end
      @user.save
      return res(500, 'Could not save topics.') unless @user.saved?
      create_reading_lists(@user) if @user.reading_lists.empty?
      res(201, 'Topics saved successfully.')
    elsif @user.topics.empty?
      res(500, 'Surely, you want to learn something?')
    end
  end

  get '/unfollow/:id' do
    @topic = Topic.first(id: params[:id])
    @user.topics.delete(@topic)

    if @user.save
      redirect '/topics' if @user.topics.empty?
      redirect '/'
    end
  end
end
