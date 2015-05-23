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
  # require './models/song'
  require './models/user'

  # Routes
  #Got the first route from rails maybe need to incorporate it ino the second route
  get '/' do
    if current_user
      erb :authenticated
    else
      erb :not_authenticated
    end
  end

  get '/' do
    if current_user
      "You are logged in"
    else
      "Please log in"
    end
  end

  post '/users' do
    user = User.new(params[:user])
    user.password = params[:password]  # Setting: Doing the hashing
    user.save!  # save in place
    redirect '/'
  end

  # Sign-In
  post '/sessions' do
    user = User.find_by(username: params[:username])
    if (user.password == params[:password])  # Does the password match?
      session[:current_user] = user.id
      redirect '/' # Authenticated
    else
      redirect '/' # Not Authenticated
    end
  end

  # Log-out
  delete '/sessions' do
    session[:current_user] = nil
    redirect '/'
  end


  # get '/api/songs' do
  #   content_type :json
  #   songs = Song.all
  #   songs.to_json
  # end
  #
  # get '/api/songs/:id' do
  #   content_type :json
  #   song = Song.find(params[:id].to_i)
  #   song.to_json
  # end
  #
  # post '/api/songs' do
  #   content_type :json
  #   song = Song.create(params[:song])
  #   song.to_json
  # end
  #
  # put '/api/songs/:id' do
  #   content_type :json
  #   song = Song.find(params[:id].to_i)
  #   song.update(params[:song])
  #   song.to_json
  # end
  #
  # patch '/api/songs/:id' do
  #   content_type :json
  #   song = Song.find(params[:id].to_i)
  #   song.update(params[:song])
  #   song.to_json
  # end
  #
  # delete '/api/songs/:id' do
  #   content_type :json
  #   Song.delete(params[:id].to_i)
  #   {message: 'Success'}.to_json
  # end
