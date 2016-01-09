class User < RedisModel
  lock :move_lock, expiration: 15
  hash_key :position
  value :radius

  INITIAL_RADIUS = 5
  DEFAULT_SPEED = 100
  private_constant :INITIAL_RADIUS, :DEFAULT_SPEED

  def initialize(*args)
    super(*args)

    position.empty? && position.bulk_set(x: rand(100), y: rand(100))
    radius.nil? && (self.radius = INITIAL_RADIUS)
  end

  def move(pos)
    position.bulk_set(calculate_position(pos))
    MoveBroadcastJob.perform_later(UserSerializer.new(self).as_json)
  end

  private

  def calculate_position(pos)
    speed = 10 * INITIAL_RADIUS / radius.to_f

    calculate_vector_coord = ->(coord) do
      pos[coord].to_f - position[coord].to_f
    end

    calculate_vector_length = ->(vec) do
      Math.sqrt(vec[:x] ** 2 + vec[:y] ** 2) + 0.01 # spike to prevent zero-division
    end

    vec = { x: calculate_vector_coord.('x'), y: calculate_vector_coord.('y') }
    length = calculate_vector_length.(vec)

    {
      x: position['x'].to_i + (vec[:x] / length) * speed,
      y: position['y'].to_i + (vec[:y] / length) * speed
    }
  end
end
