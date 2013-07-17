get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/urls' do 
  Url.shorten(params)
  @urls = Url.all
  erb :list_urls
end

get '/:short_url' do
  url_data = Url.find_by_shortened_url(params[:short_url])
  url_data.update_attributes(:clicks => url_data[:clicks] +1 )
  redirect to "#{url_data[:original_url]}"

end
  # @new_url = Url.create(:original_url => params[:url][:original_url],
  #             :shortened_url => short_url,
  #             :description => params[:url][:description])
