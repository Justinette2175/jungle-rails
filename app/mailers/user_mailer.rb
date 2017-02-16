class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

  def order_email(order)
    @order = order
    @url  = 'http://example.com/login'
    mail(to: 'jugagnepain75@gmail.com', subject: 'Your order')
  end

end
