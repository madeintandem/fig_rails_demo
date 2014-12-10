#Fig + Docker for rails dev

The goal here is to demonstrate a Docker based development environment. This means we will only be running our dependent services on Docker, not the app. A `Dockerfile` for the application can be easily added and linked into this Fig configuration but consensus is that running `rails s` locally is easier for debugging, testing, and editing.

When you have multiple projects locally which depend on different versions of multiple services, setting up your machine can be a pain. Returning to an older project can be especially difficult if it depends on old versions of the datastore or search appliance. This project aims to freeze the services configuration leveraging Docker containers and tieing them all together with Fig.

So let's get started.

## Prereqs

* Docker (boot2docker for osx)
* Ruby 1.9.3 or higher

#### OSX setup

We need to install virtualbox, boot2docker and fig. If you don't have [brew cask](https://github.com/caskroom/homebrew-cask) installed, then you can't run these two glorious commands and get to go all clicky clicky on your mousey mouse.

```
brew cask install virtualbox
brew cask install boot2docker
brew install boot2docker
pip install -U fig
```

Only once people:

```
boot2docker init
```

If docker is not running as a daemon:

```
boot2docker up
```

###### boot2docker host

boot2docker does some super goofy stuff with networking so we have to figure out what ip it is running on. I think the easiest way is to initialize your shell and have RAILS read it from your `.bash_profile`.

```
eval $(boot2docker shellinit 2> /dev/null)
export DOCKER_IP=$(boot2docker ip 2>/dev/null)
```

Note: "boot2docker" must be running for this to work correctly. If you haven't started the guest machine you'll need to do so and source your .profile again.

#### Linux setup

I think this may be easier since you don't have to muck with boot2docker and virtualbox, but there may be more things to consider around ports being in use and what not.

If you're a Linux user, fill this section out and/or give me your feedback.

## Running fig

```
fig up
```

The first run will be painful thanks to the slowness of American internet, but subsequent runs will be awesome until your drive becomes full with docker images.

### Running the demo app

The demo app uses Postgres, Elasticsearch and Redis. Postgres and Redis are direct from the registry image. Elasticsearch is from a `Dockerfile` located in `docker/elasticsearch`. I just copied this directly from the image at the registry but it establishes convention for using your own docker files.

The only things to know about the app's configuration are in the `config/database.yml`, `config/initializers/elasticsearch.rb` and `config/initializers/redis.rb`. You may wish to do something more sophisticated, but this is the bare minimum.

Then fire it up!

```
gem install bundler
bundle install
rake db:setup       #this proves our database is alive
rails s
```

After that you should be able to browse to `http://localhost:3000` and see information printed out about the services the app has connections to.


## Why isn't the app dockerized?

Because it's a pain for development, especially for debugging. There's nothing stopping you from extending the fig.yml to also do a Rails/Web container, linking them, and tossing the whole thing into production. But it's not the scope of this.


## Next steps?

Who knows? This was so quick and painless I don't think there's much more I need to experiment with but open an issue/pr if there's a change or addition you'd like to see.

-------------------------------------------------------------------------------

#License

Copyright (c) 2014 Joseph Hirn

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
