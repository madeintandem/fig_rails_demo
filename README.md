#Fig + Docker for rails dev

The goal here is to demonstrate a docker environment for a Rails app for development use. This means we will only be running our dependent services on docker and not the app. A docker file for the application can easily be added and linked into this fig configuration but consensus is that running rails s locally is easier for debugging.

What we do desire is a way to facilitate working on multiple projects locally which depend on multiple versions of various services. So let's get started.

## Prereqs

* Docker (boot2docker for osx)
* Ruby 1.9.3 or higher

###For OSX

We need to install virtualbox, boot2docker and fig. If you don't have [brew cask](https://github.com/caskroom/homebrew-cask) installed, then you can't run these two glorious commands and get to go all clicky clicky on your mousey mouse.

```
brew cask install virtualbox
brew cask install boot2docker
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

#### boot2docker host

boot2docker does some super goofy stuff with networking so we have to figure out what ip it is running on. I think the easiest way is to initialize your shell and have RAILS read it from your `.bash_profile`.

```
eval $(boot2docker shellinit) 2> /dev/null
export DOCKER_IP=$(boot2docker ip 2>/dev/null)
```

Note: "boot2docker" must be running for this to work correctly. If you haven't started the guest machine you'll need to do so and source your .profile again.

###For Linux

I think this may be easier since you don't have to muck with boot2docker and virtualbox, but there may be more things to consider around ports being in use and what not.

If you're a Linux user, fill this section out and/or give me your feedback.

## Running fig

```
fig up
```

The first run will be painful thanks to the slowness of American internet, but subsequent runs will be awesome until your drive becomes full with docker images.

### Running the demo app

```
gem install bundler
bundle install
rake db:setup
rails s
```

The demo app uses Postgres, Elasticsearch and Redis. Postgres and Redis are direct from the registry image. Elasticsearch is from a `Dockerfile` located in `docker/elasticsearch`. I just copied this directly from the image at the registry but it establishes convention for using your own docker files.

### Why isn't the app dockerized?

Because it's a pain for development, especially for debugging. There's nothing stopping you from extending the fig.yml to also do a Rails/Web container, linking them, and tossing the whole thing into production. But it's not the scope of this.


## Next steps?

Who knows? This was so quick and painless I don't think there's much more I need to experiment with but open an issue/pr if there's a change or addition you'd like to see.

-------------------------------------------------------------------------------

#License

We don't need no stinkin license. 2014
