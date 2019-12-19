# frozen_string_literal: true

require 'test_helper'

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = { email: 'test1@mail.com', password: 'qwerty' }
  end

  test "should get login" do
    get new_user_session_url
    assert_response :success
  end

  test "cant_create_review_without_login" do
    get '/ru/movies/1/reviews/new'
    assert_response :redirect
  end

  test "should_registrate_before_creating" do
    post user_registration_url, params: { user: { email: @user[:email], password: @user[:password], password_confirmation: @user[:password] } }
    get '/ru/movies/1/reviews/new'
    assert_response :success
  end

  test "sign_in_and_create" do
    post user_registration_url, params: { user: { email: @user[:email], password: @user[:password], password_confirmation: @user[:password] } }
    get destroy_user_session_url
    post user_session_url, params: { user: { email: @user[:email], password: @user[:password] } }
    get '/ru/movies/1/reviews/new', params: { rating: '3', comment: 'bjrbje' }
    assert_response :success
  end
end
