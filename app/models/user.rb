class User < ActiveRecord::Base
  searchable do
    text :name
    text :location
    time :created_at
  end
end
