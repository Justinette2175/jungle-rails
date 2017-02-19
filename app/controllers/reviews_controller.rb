class ReviewsController < ApplicationController
  def create
    @review = Review.new
    @id = @review.product_id
    @review.save
    redirect_to :back, notice: 'Review created!'
  end
end
