class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user#sign_in userでは、ゲストユーザーをログイン状態にします
    redirect_to user_path(user), notice: 'guestuserでログインしました。'
    #ゲストユーザーの詳細ページへと遷移させます
  end
end