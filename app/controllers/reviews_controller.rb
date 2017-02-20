class ReviewsController < ApplicationController

  before_filter :authorize

  def create
    @review = Review.new(review_params)
    if @current_user
      @review.user = @current_user
    else
      @review.user = User.new(:first_name => "anonymous")
    end
    @review.save
    if @review.save!
      redirect_to :back, notice: 'Review created!'
    else
      puts "review was not saved"
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to :back, notice: "Review removed!"
  end

  private

  def review_params
    params.require(:review).permit(:product_id, :description, :rating)
  end
end
