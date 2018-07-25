# frozen_string_literal: true

require_relative '../spec_helper'

describe TopicsController do
  let!(:user) { create(:user) }
  let!(:topic) { create(:topic) }

  context 'When authenticated user visits topics' do
    before do
      stub_current_user(user)
      get '/topics'
    end
    it 'should display topics' do
      expect(last_response.status).to eq(200)
    end
  end

  context 'When a user follows a new topic' do
    before do
      stub_current_user(user)
      post '/topics', selected_topics: ['JavaScript']
    end
    it 'should associate topic to user' do
      expect(last_response.status).to eq(201)
      expect(user.topics).to include(topic)
    end
  end

  context 'When an unauthenticated user posts to "/topics"' do
    before do
      post '/topics', selected_topics: ['JavaScript']
    end
    it 'should redirect to "/"' do
      expect(last_request.session[:flash][:danger])
        .to match(/You're not authorized. Please Log In.*/)
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end

  context 'When an first time user posts no selected_topics to "/topics"' do
    before do
      stub_current_user(user)
      post '/topics'
    end
    it 'should return error response' do
      expect(last_response.status).to eq(500)
      expect(last_response.body)
        .to match(/Surely, you want to learn something?.*/)
    end
  end
end
