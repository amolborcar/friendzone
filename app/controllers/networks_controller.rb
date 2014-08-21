class NetworksController < ApplicationController

  def index
  end

  def search
  end

  def sign_in
    @request_token = session[:request_token]
    @host = request.host
    redirect_to Authorizer.request_token(@request_token, @host).authorize_url
  end

  def auth
    # @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
    # puts @access_token
    # session.delete(:request_token)
    # save_token(@access_token)
  end

end
