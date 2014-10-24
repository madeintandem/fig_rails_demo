class HomeController < ApplicationController

  def index
    @es_client = Elasticsearch::Model.client
    @pg_config = ActiveRecord::Base.connection_config
  end
end
