Elasticsearch::Model.client  = Elasticsearch::Client.new(
  {
    host: "http://#{ENV['DOCKER_IP']}:9200"
  }
)
