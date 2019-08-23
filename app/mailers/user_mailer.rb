class UserMailer < ActionMailer::Base
  default from: "LTHR <welcome@lthr.com>"

  def signup_email(user)
    @user = user
    @twitter_message = "CLICK 2 WIN a chance to receive a free LTHR pre-order!"

    mail(:to => user.email, :subject => "Thanks for signing up!")
  end
end
