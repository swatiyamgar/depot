def login_user
  user = create :user
  session[:user_id] = user.id
  session[:counter] = 1
  user
end
