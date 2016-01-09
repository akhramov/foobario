class RedisModel
  include ActiveModel::SerializerSupport
  include Redis::Objects

  class InstanceNotFound < StandardError; end

  class << self
    def all
      @instances ||= Redis::Objects.redis
        .scan_each(match: "#{name.underscore}:*")
        .map do |key|
          /:(?<id>.*):/ =~ key
          new(id)
        end.uniq(&:id)
    end
  end

  attr_reader :id

  def initialize(id = SecureRandom.uuid)
    @id = id
  end
end
