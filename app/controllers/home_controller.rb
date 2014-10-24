class HomeController < ApplicationController

  def index
    @es_client= Elasticsearch::Model.client
  end
end
