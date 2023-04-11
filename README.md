# TDD_route_with_database

This is a Sinatra application that serves as an API for managing artists and their albums.

## Getting Started
To get started with this application, you'll need to have Ruby installed. Clone the repository and run the following command to install the required gems:

```
bundle install
```

To run the application, use the following command:

```
rackup
```

## Usage
The application has the following endpoints:

- `/artists`: Returns a list of all artists.
- `/artists/new`: Renders a form to create a new artist.
- `/artists/:id`: Returns the details of a specific artist.
- `/albums`: Returns a list of all albums.
- `/albums/new`: Renders a form to create a new album.
- `/album/:id`: Returns the details of a specific album.


## Dependencies
This application requires the following dependencies:

- Sinatra
- Sinatra Reloader
- PostgreSQL

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/SimpleLuke/TDD_route_with_database. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Contributor Covenant code of conduct.

