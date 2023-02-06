require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'POST /albums' do
    it 'returns 200 and creates a new album' do
      response = post('/albums', title:'Votage', release_year:2022, artist_id:2)

      expect(response.status).to eq 200
      expect(response.body).to eq ''

      response = get('/albums')
      expect(response.body).to include('Votage')
    end
  end

  context 'GET /artists' do
    it 'returns 200 OK with artist names' do
      response = get('/artists')

      expect(response.status).to eq 200
      expect(response.body).to eq 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos'
    end
  end

  context 'POST /artists' do
    it 'returns 200 OK and creates a new artist in the database' do
      response = post('/artists',name:'Wild nothing',genre:'Indie')

      expect(response.status).to eq 200 
      expect(response.body).to eq ''

      response = get('/artists')
      expect(response.status).to eq 200
      expect(response.body).to eq 'Pixies, ABBA, Taylor Swift, Nina Simone, Kiasmos, Wild nothing'

    end
  end
end