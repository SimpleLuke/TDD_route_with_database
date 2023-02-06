# file: app.rb
require 'sinatra'
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

  get '/albums' do
    repo = AlbumRepository.new
    albums = repo.all

    response = albums.map {|album| album.title}.join(',')

    return response
  end

  post '/albums' do
    title, release_year, artist_id = params[:title], params[:release_year], params[:artist_id]
    album = Album.new
    album.title = title
    album.release_year = release_year
    album.artist_id = artist_id

    repo = AlbumRepository.new
    repo.create(album)

    return nil 
  end

  get '/artists' do
    repo = ArtistRepository.new
    artists = repo.all

    response = artists.map {|artist| artist.name}.join(', ')

    return response
  end

  post '/artists' do
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    repo = ArtistRepository.new
    repo.create(artist)

    return ''
  end
end