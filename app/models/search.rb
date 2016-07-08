class Search
  attr_reader :query

  def initialize(query)
    @query = query
  end

  def users
    Sunspot.search(User) do
      fulltext query
      order_by :created_at
    end.results
  end
end
