require 'json'
require 'selenium-webdriver'
require 'test_helper'

PASSWORD = '111111'
USER_EMAIL = 'selenium@gmail.com'
PASSWORD.freeze
USER_EMAIL.freeze

class Registration < ActionDispatch::IntegrationTest

  def setup
    @driver = Selenium::WebDriver.for :chrome
    @base_url = 'http://localhost:3000/en/'
    @accept_next_alert = true
    @driver.manage.timeouts.implicit_wait = 30
    @verification_errors = []
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end

  test '1_registration' do
    @driver.get(@base_url + 'users/sign_in')
    @driver.find_element(:link, 'Sign Up').click
    assert element_exists?(:link, 'Sign In')
    @driver.find_element(:id, 'user_email').clear
    @driver.find_element(:id, 'user_email').send_keys USER_EMAIL
    @driver.find_element(:id, 'user_password').clear
    @driver.find_element(:id, 'user_password').send_keys PASSWORD
    @driver.find_element(:id, 'user_password_confirmation').clear
    @driver.find_element(:id, 'user_password_confirmation').send_keys PASSWORD
    @driver.find_element(:name, 'commit').click
    assert element_exists?(:link, 'Account')
  end

  test '2_sign_in' do
    sign_in
  end

  test '3_create_movie' do
    sign_in
    @driver.find_element(:link, 'New Movie').click
    @driver.find_element(:id, 'movie_title').send_keys 'New film'
    @driver.find_element(:id, 'movie_description').send_keys 'Some text'
    @driver.find_element(:id, 'movie_movie_length').send_keys '1:00'
    @driver.find_element(:id, 'movie_director').send_keys 'Some person'
    @driver.find_element(:id, 'movie_rating').send_keys 'pg 13'
    @driver.find_element(:id, 'movie_image').send_keys nil
    @driver.find_element(:name, 'commit').click
    assert element_exists?(:link, 'Write review')
    @driver.find_element(:link, 'Movie Reviews').click
    @driver.find_element(:link, 'btntext').click
  end


  test '4_sign_out' do
    sign_in
    @driver.find_element(:link, 'Exit').click
    assert element_exists?(:link, 'Sign In')
  end

private

  def sign_in
    @driver.get(@base_url)
    @driver.find_element(:link, 'Sign In').click
    assert element_exists?(:link, 'Sign In')
    @driver.find_element(:id, 'user_email').clear
    @driver.find_element(:id, 'user_email').send_keys USER_EMAIL
    @driver.find_element(:id, 'user_password').clear
    @driver.find_element(:id, 'user_password').send_keys PASSWORD
    @driver.find_element(:name, 'commit').click
    assert element_exists?(:link, 'Account')
  end

  def element_present?(how, what)
    @driver.find_element(how, what)
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def element_exists?(how, what)
    !10.times do
      break if begin
        element_present?(how, what)
      rescue StandardError
        false
      end

      sleep 1
    end
  end
end