# frozen_string_literal: true

require_relative '../spec_helper'

describe PagesController do
  let!(:user) { create(:user) }

  it 'should allow accessing home page' do
    get '/'
    expect(last_response.status).to eq(200)
  end

  context 'When authenticated user visits default route "/"' do
    before do
      stub_current_user(user)
      get '/'
    end
    it 'should redirect them to dashboard' do
      expect(last_request.session[:email]).to eq(user[:email])
      expect(last_response.status).to eq(302)
      follow_redirect!
      expect(last_request.path).to eq('/dashboard')
    end
  end

  context 'When authenticated user visits dashboard' do
    before do
      stub_current_user(user)
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
