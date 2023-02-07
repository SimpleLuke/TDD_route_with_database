require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }


  context 'GET /album/:id' do
    it 'returns the Doolittle album' do
      response = get('album/1')

    expect(response.body).to include '<h1>Doolittle</h1>'
    expect(response.body).to include 'Release year: 1989'
    expect(response.body).to include 'Artist: Pixies'
    end
  end

  context 'GET /albums' do
    it 'returns info about all albums' do
      response = get('albums')
      
    expect(response.status).to eq 200
    expect(response.body).to include '<h1>Albums</h1>'
    expect(response.body).to include 'Title: Doolittle'
    expect(response.body).to include '<a href="/album/1">Link</a>'
    expect(response.body).to include 'Title: Surfer Rosa'
    expect(response.body).to include '<a href="/album/2">Link</a>'
    end
  end

  context 'POST /albums' do
    it 'returns 200 and creates a new album and a success page' do
      response = post('/albums', title:'Votage', release_year:2022, artist_id:2)

      expect(response.status).to eq 200
      expect(response.body).to include '<p>You created the Votage album!</p>'

      response = get('/albums')
      expect(response.body).to include('Votage')
    end
  end

  context 'GET /artists' do
    it 'returns 200 OK and HTML page with the list of artists with a link to the artist page' do
      response = get('/artists')

      expect(response.status).to eq 200
    expect(response.body).to include '<a href="/artists/1">Pixies</a>'
    expect(response.body).to include '<a href="/artists/2">ABBA</a>'
    end
  end

  context 'GET /artists/:id' do
    it 'returns 200 OK and shows details for Pixies with /artists/1' do
      response = get('/artists/1')

      expect(response.status).to eq 200
      expect(response.body).to include 'Artist: Pixies'
      expect(response.body).to include 'Genre: Rock'
    end

    it 'returns 200 OK and shows details for ABBA with /artists/2' do
      response = get('/artists/2')

      expect(response.status).to eq 200
      expect(response.body).to include 'Artist: ABBA'
      expect(response.body).to include 'Genre: Pop'
    end
  end

  context 'POST /artists' do
    it 'returns 200 OK and creates a new artist in the database' do
      response = post('/artists',name:'Wild nothing',genre:'Indie')

      expect(response.status).to eq 200 
      expect(response.body).to eq ''

      response = get('/artists')
      expect(response.status).to eq 200
      expect(response.body).to include 'Wild nothing'

    end
  end
  
  context 'GET /albums/new' do
    it 'returns 200 and creates a new album' do
      response = get('/albums/new')

    expect(response.status).to eq 200
    expect(response.body).to include '<form action="/albums" method="POST">'
    expect(response.body).to include '<label for="title">Title:</label>'
      expect(response.body).to include '<input type="text" name="title" />'
    end
  end

end
