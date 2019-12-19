# frozen_string_literal: true

require 'test_helper'

class MoviesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = { email: 'test1@mail.com', password: 'qwerty' }
  end

  test 'should get login' do
    get new_user_session_url
    assert_response :success
  end

  test 'cant_create_movie_without_login' do
    get new_movie_url
    assert_response :redirect
  end

  test 'should_registrate_before_creating,' do
    post user_registration_url, params: { user: { email: @user[:email], password: @user[:password], password_confirmation: @user[:password] } }
    get new_movie_url
    assert_response :success
  end

  test 'sign_in_and_create' do
    post user_registration_url, params: { user: { email: @user[:email], password: @user[:password], password_confirmation: @user[:password] } }
    get destroy_user_session_url
    post user_session_url, params: { user: { email: @user[:email], password: @user[:password] } }
    get new_movie_url, params: { title: 'rhkg', description: 'bjrbje', movie_length: '1:30', rating: '5', image: 'nil' }
    assert_response :success
  end
end
