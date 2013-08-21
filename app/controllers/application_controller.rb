class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :ip_identifer

  def ip_identifer
  	if request.env["HTTP_X_FORWARDED_FOR"]
  		 ip =  request.env["HTTP_X_FORWARDED_FOR"].split(",").first
  	elsif request.env["REMOTE_ADDR"]
  		 ip = request.env["REMOTE_ADDR"]
  	end
  	ip
  end

end
