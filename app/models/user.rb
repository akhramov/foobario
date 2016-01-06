class User < ApplicationRecord
  lock :move, expiration: 15
  hash_key :position

  def move(x:, y:)
  end
end
