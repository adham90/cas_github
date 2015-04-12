# GCAS

The Github Central Authentication Service (GCAS) is a single sign-on protocol work with github oauth system for the web. Its purpose is to permit a user to access multiple applications while providing their credentials only once. It also allows web applications to authenticate users without gaining access to a user's security credentials.

## Installation
Example with sqlite database:

1. `$ git clone git@github.com:geekhub-io/cas_github.git`
2. `$ cd cas_github`
3. `$ bundle install`
4. `$ bundle exec rake db:migrate`
5. `$ cd lib/cas_github/app`
6. `$ rackup`

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it ( https://github.com/[my-github-username]/cas_github/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
GCAS is licensed for use under the terms of the MIT License.
