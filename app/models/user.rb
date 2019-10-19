class User < ApplicationRecord
  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id', optional: true
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'

  validates :email, presence: true, :uniqueness => {:case_sensitive => false, :message => "Email is already taken"}
  validates :email, 'valid_email_2/email': { mx: true, message: "is not a valid email. Please enter valid email" }
  validates :referral_code, uniqueness: true

  before_create :create_referral_code
  after_create :send_welcome_email
   
  def user_url(root_url)
    root_url + "users/" + referral_code
  end  

  private

  def create_referral_code
    self.referral_code = UsersHelper.unused_referral_code
  end

  def send_welcome_email
    UserMailer.signup_email(self).deliver_later
  end

end
