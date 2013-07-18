get '/' do
    @urls = Url.all
    erb :index
end


get '/create_user' do
  # Look in app/views/index.erb
  erb :create_user
end

post '/urls' do 
  @new_url = Url.shorten(params)
  if @new_url.save
    redirect '/'
  else
    @errors = @new_url.errors.full_messages
    @urls = Url.all
    erb :index
  end
end


get '/logout' do
  session.clear
  redirect '/'
end


get '/:short_url' do
  p params
  url_data = Url.find_by_shortened_url(params[:short_url])
  p url_data
  url_data.update_attributes(:clicks => url_data[:clicks] +1 )
  redirect to "#{url_data[:original_url]}"
end
  # @new_url = Url.create(:original_url => params[:url][:original_url],
  #             :shortened_url => short_url,
  #             :description => params[:url][:description])



post '/create_user' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect to "/user_profile/#{@user.id}"
  else
    redirect to '/'
  end
end

post '/login' do
  @user = User.authenticate(params[:user][:email], params[:user][:password])
  if @user
    session[:user_id] = @user.id
    redirect to "/user_profile/#{@user.id}"
  else
    @error = 'Invalid Login Info'
  end
end

get '/user_profile/:user_id' do 
  @user = User.find(params[:user_id]) 
  if @user.id == current_user.id
    erb :user_profile
  else
    @error = "Page not found... Your mom."
    erb :user_profile
  end
end





post '/favorite_url' do
  p params
  omgmyfav = FavoriteWebsite.new(:user_id => current_user.id, :url_id => params[:favorite][:url_id])
  if omgmyfav.save
    erb :user_profile
  else
    redirect '/'
  end
end

post '/delete_fav' do
  sad_url = FavoriteWebsite.where("user_id = ? AND url_id = ?", current_user.id, params[:sadurl_id])
  FavoriteWebsite.find(sad_url.first.id).destroy
  redirect "/user_profile/#{current_user.id}"
end





