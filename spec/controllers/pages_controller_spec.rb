# frozen_string_literal: true

require_relative '../../microlearn'
require_relative '../spec_helper'

describe 'Routes' do
  let!(:user) { create(:user) }
  let!(:user_credentials) do
    { email: 'test@user.com', password: 'Testpassword1' }
  end

  context 'When authenticated user visits default route "/"' do
    before do
      post '/login', user_credentials
      get '/'
    end
    it 'should redirect them to dashboard' do
      expect(last_request.session[:email]).to eq(user_credentials[:email])
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path).to eq('/dashboard')
    end
  end

  context 'When authenticated user visits topics' do
    before do
      post '/login', user_credentials
      get '/topics'
    end
    it 'should display topics' do
      expect(last_response.status).to eq(200)
    end
  end

  context 'When authenticated user visits dashboard' do
    before do
      post '/login', user_credentials
      get '/dashboard'
    end
    it 'should display dashboard' do
      expect(last_response.status).to eq(200)
    end
  end

  context 'When an unauthenticated user visits dashboard' do
    before do
      get '/dashboard'
    end
    it 'should redirect them to "/"' do
      expect(last_request.session[:flash][:danger])
        .to match(/You're not authorized. Please Log In.*/)
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end

  context 'When an unauthenticated user visits topics' do
    before do
      get '/topics'
    end
    it 'should redirect them to "/"' do
      expect(last_request.session[:flash][:danger])
        .to match(/You're not authorized. Please Log In.*/)
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end
end
