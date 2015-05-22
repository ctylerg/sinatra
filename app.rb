  require 'bundler'
  Bundler.require()


  # Connection
  ActiveRecord::Base.establish_connection(
    :adapter => 'postgresql',
    :database => 'ratpack'
    )

  #Sessions
    enable(:sessions)

    #Helpers
    def current_user
      if session[:current_user]
        User.find(session[:current_user])
      else
        nil
      end
    end

  def authenticate!
    redirect '/' unless current_user
  end


  # Models
  require './models/song'


  # Routes
  #Got the first route from rails maybe need to incorporate it ino the second route
  get '/' do
    if current_user
      erb :authenticated
    else
      erb :not_authenticated
    end
  end


  get '/api/songs' do
    content_type :json
    songs = Song.all
    songs.to_json
  end

  get '/api/songs/:id' do
    content_type :json
    song = Song.find(params[:id].to_i)
    song.to_json
  end

  post '/api/songs' do
    content_type :json
    song = Song.create(params[:song])
    song.to_json
  end

  put '/api/songs/:id' do
    content_type :json
    song = Song.find(params[:id].to_i)
    song.update(params[:song])
    song.to_json
  end

  patch '/api/songs/:id' do
    content_type :json
    song = Song.find(params[:id].to_i)
    song.update(params[:song])
    song.to_json
  end

  delete '/api/songs/:id' do
    content_type :json
    Song.delete(params[:id].to_i)
    {message: 'Success'}.to_json
  end
