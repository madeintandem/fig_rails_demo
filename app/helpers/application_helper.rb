module ApplicationHelper
  def print_hash(hash)
    raw JSON.pretty_generate(hash).gsub(" ","&nbsp;")
  end
end
