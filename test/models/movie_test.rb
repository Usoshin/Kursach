# frozen_string_literal: true

require 'test_helper'

class MovieTest < ActiveSupport::TestCase
  test 'should not create movie' do
    movie = Movie.new
    assert !movie.save
  end

  test 'should find movie' do
    assert Movie.exists?(id: 1)
  end

  test 'shoud not save with save fields' do
    movie = Movie.new
    movie.id = 1
    movie.title = 'New film'
    assert !movie.save
  end
end
# title: "Iron Man 3",
