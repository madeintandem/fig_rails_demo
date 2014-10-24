#Fig + Docker for rails dev

The goal here is to demonstrate a docker environment for a Rails app for development use. This means we will only be running our dependant services on docker and not the app. A docker file for the application can easily be added and linked into this fig configuration but consensus is that running rails s locally is easier for debugging.

What we do desire is a way to facilitate working on multiple projects locally which depend on multiple versions of various services. So let's get started.

## Prereqs

This requires you have docker ready to run on your machine.

###For OSX

We need to install virtualbox, boot2docker and fig. If you don't have brew cask installed, then you can't run these two glorious commands and get to go all clicky clicky on your mousey mouse.

```
brew cask install virtualbox
brew cask install boot2docker
pip install -U fig
```

boot2docker does some super goofy stuff with networking so we have to figure out what ip it is running on. I think the easiest way is to initialize your shell and have RAILS read it from your env.

```
eval $(boot2docker shellinit) 2> /dev/null
export DOCKER_IP=$(boot2docker ip 2>/dev/null)
```

###For Linux

``` Follow your neckbeard```

But I think this may be easier since you don't have to muck with boot2docker and virtualbox. If you're a linux user, fill this section out!!!


## Getting started

After your prereqs are installed, you should be able to `fig up` and run this demo app. The first run will be painful thanks to the slowness of American internet, but subsequent runs will be awesome until your drive becomes full with docker images. Don't worry though, that MacBook refresh is otw.

The demo app uses postgres and elasticsearch. Postgres is direct from the registry image. Elasticsearch is from a `Dockerfile` located in `docker/elasticsarch`. I just copied this directly from the image at the registry but it establishes convention for using your own docker files.
