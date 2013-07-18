get '/' do
  @urls = Url.all
  # Look in app/views/index.erb
  erb :index
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

get '/:short_url' do
  url_data = Url.find_by_shortened_url(params[:short_url])
  url_data.update_attributes(:clicks => url_data[:clicks] +1 )
  redirect to "#{url_data[:original_url]}"

end
  # @new_url = Url.create(:original_url => params[:url][:original_url],
  #             :shortened_url => short_url,
  #             :description => params[:url][:description])
