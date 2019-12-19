# frozen_string_literal: true

require 'test_helper'

class ReviewTest < ActiveSupport::TestCase
  test 'should not create review' do
    review = Review.new
    assert !review.save
  end

  test 'should find review' do
    assert Review.exists?(id: 1)
  end

  test 'shoud not save with save fields' do
    review = Review.new
    review.id = 1
    review.comment = 'Aveasome film'
    assert !review.save
  end
end
