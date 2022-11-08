# Github::Client


## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add github-client

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install github-client

## Usage

To test, run `./bin/console`

```ruby
Github.configure(endpoint:"https://api.github.com/")
Github::Score.new(user_name: "tenderlove").event_score

```