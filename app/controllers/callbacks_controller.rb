class CallbacksController < Devise::OmniauthCallbacksController
  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])
    # pp @user.errors
    sign_in @user
    redirect_to root_path # redirige al home
  end

  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in @user
    redirect_to root_path
  end
end
