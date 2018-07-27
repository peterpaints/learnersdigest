# frozen_string_literal: true

require_relative '../spec_helper'

describe AuthController do
  let(:user_credentials) do
    { email: 'test@user.com', password: 'Testpassword1' }
  end

  context 'When user registers with valid credentials' do
    it 'should redirect to "/topics" and save email in session' do
      post '/register', user_credentials
      expect(last_request.session[:flash]).to be_nil
      expect(last_request.session[:email]).to eq(user_credentials[:email])
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path).to eq('/topics')
    end
  end

  context 'When existing user attempts to register' do
    it 'should display error message and redirect' do
      create(:user)
      post '/register', user_credentials
      expect(last_request.session[:flash][:danger])
        .to match(/User already exists. Please Log In.*/)
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end

  context 'When non-registered user attempts login' do
    it 'should display error message and redirect' do
      post '/login', user_credentials
      expect(last_request.session[:flash][:danger])
        .to match(/You do not have an account. Please register.*/)
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end

  context 'When user logs in with valid credentials' do
    it 'should login successfully' do
      create(:user)
      post '/login', user_credentials
      expect(last_request.session[:flash]).to be_nil
      expect(last_request.session[:email]).to eq(user_credentials[:email])
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path).to eq('/dashboard')
    end
  end

  context 'When user logs out' do
    before do
      create(:user)
      post '/login', user_credentials
      get '/logout'
    end
    it 'should redirect to login page' do
      expect(last_request.session[:flash]).to be_nil
      expect(last_request.session[:email]).to be_nil
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path).to eq('/')
    end
  end
end
