class ApplicationRecord
  include Redis::Objects

  attr_reader :id

  def initialize(id: SecureRandom.urlsafe_base64)
    @id = id
  end
end
