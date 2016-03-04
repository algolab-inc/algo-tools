class AuthController < ApplicationController
  def callback
    auth = request.env['omniauth.auth']
    session[:auth] = {
      credentials: auth[:credentials],
      info:        auth[:info]
    }
    redirect_to session[:redirect_path]
  end
end
