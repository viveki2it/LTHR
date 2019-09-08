class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :ref_to_cookie

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == '1'
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  protected

  def ref_to_cookie
    @experiment ||= ab_test(:my_page, ["https://lthrshaving.com/cart/28670272012340:1", "https://lthrshaving.com/cart/29407041486900:1", "https://lthrshaving.com/cart/29407049023540:1"])
    campaign_ended = Rails.application.config.ended
    return if campaign_ended || !params[:ref]

    unless User.find_by(referral_code: params[:ref]).nil?
      h_ref = { value: params[:ref], expires: 1.week.from_now }
      cookies[:h_ref] = h_ref
    end

    user_agent = request.env['HTTP_USER_AGENT']
    return unless user_agent && !user_agent.include?('facebookexternalhit/1.1')
    redirect_to proc { url_for(params.permit(:ref).except(:ref)) }
  end
  
  def flatten_errors errors
    errors.values.flatten.join("; ")
  end  
end
