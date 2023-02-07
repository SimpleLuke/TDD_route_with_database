# file: app.rb
require 'sinatra/base'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  # get '/albums' do
  #   repo = AlbumRepository.new
  #   albums = repo.all
  #
  #   response = albums.map {|album| album.title}.join(',')
  #
  #   return response
  # end

  post '/albums' do
    title, release_year, artist_id = params[:title], params[:release_year], params[:artist_id]
    album = Album.new
    album.title = title
    album.release_year = release_year
    album.artist_id = artist_id

    @album_title = title

    repo = AlbumRepository.new
    repo.create(album)

    return erb(:album_created) 
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all

    # response = artists.map {|artist| artist.name}.join(', ')

    return erb(:artists)
  end

  post '/artists' do
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    repo = ArtistRepository.new
    repo.create(artist)

    return ''
  end

  get '/artists/:id' do
  repo = ArtistRepository.new
  @artist = repo.find(params[:id])

    return erb(:artist)
  end

  get '/albums/new' do
    
    return erb(:new_album)
  end

  get '/album/:id' do
    album_repo = AlbumRepository.new
    album = album_repo.find(params[:id])

    @title = album.title
    @release_year = album.release_year
    artist_id = album.artist_id

    artist_repo = ArtistRepository.new
    artist = artist_repo.find(artist_id)
    @artist_name = artist.name
    return erb(:album)
  end

  get '/albums' do
    repo = AlbumRepository.new

    @albums = repo.all

    return erb(:albums)
  end
end
