# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not create user' do
    user = User.new
    assert !user.save
  end

  test 'should find user' do
    assert User.exists?(id: 1)
  end

  test 'shoud not save with save fields' do
    user = User.new
    user.id = 1
    user.email = '12@mail.ru'
    assert !user.save
  end
end
