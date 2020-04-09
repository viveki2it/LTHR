class User < ApplicationRecord
  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id', optional: true
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'

  validates :email, presence: true, :uniqueness => {:case_sensitive => false, :message => "Email is already taken"}
  validates :email, 'valid_email_2/email': { mx: true, disposable: true, message: "is not a valid email. Please enter valid email" }
  validates :referral_code, uniqueness: true
  # validate :verify_email

  before_create :create_referral_code
  after_create :send_welcome_email
   
  def user_url(root_url)
    root_url + "users/" + referral_code
  end
  
  def verify_email
    address = ValidEmail2::Address.new(self.email)
    if address.valid? && address.valid_mx?
      mailgun_validate = get_validate(self.email)
      unless mailgun_validate.dig('result').eql?('deliverable')
        errors.add(:email, "is not a valid email. Please enter valid email")
      end
    else
      errors.add(:email, "is not a valid email. Please enter valid email")
    end
  end
  

  private

  def create_referral_code
    self.referral_code = UsersHelper.unused_referral_code
  end

  def send_welcome_email
    UserMailer.signup_email(self).deliver_later
  end

  def get_validate(email)
    url_params = { address: email }
    public_key = ENV['MAILGUN_API_KEY']
    validate_url = "https://api.mailgun.net/v4/address/validate"
    response = RestClient::Request.execute method: :get, url: validate_url, headers: { params: url_params }, user: 'api', password: public_key
    response_json = JSON.parse response
    response_json
  end  

end
