class UserMailer < ActionMailer::Base
  default from: "LTHR <welcome@lthr.com>"

  def signup_email(user)
    @user = user
    @twitter_message = "Ready to elevate your shave? Here is your limited-time chance to win a pre-order LTHR hot shaving machine!"

    mail(:to => user.email, :subject => "Thanks for signing up!")
  end
end
