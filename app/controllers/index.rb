get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/urls' do data pieces 1 & 2
  short_url = shortner
  @new_url = Url.create {:original_url => params[:url][:original_url],
              :shortened_url => short_url,
              :description => params[:url][:description]}
  @urls = Url.all
  erb :list_urls
end


# e.g., /q6bda
get '/:short_url' do
  url_data = Url.find_by_shortened_url(params[:short_url])
  redirect to "http://#{url_data[:original_url]}"

end
