class UserMailer < ActionMailer::Base
  default from: "LTHR <welcome@lthr.com>"

  def signup_email(user)
    @user = user
    @twitter_message = "Ready to elevate your shave? Limited-time chance to win a @LTHR hot shaving machine! (#{ENV['DEFAULT_MAILER_HOST'])"

    mail(:to => user.email, :subject => "Thanks for signing up!")
  end
end
