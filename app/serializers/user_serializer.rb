class UserSerializer < ActiveModel::Serializer
  attributes :id, :position, :radius

  def position
    object.position.to_h.fetch_values('x', 'y').map(&:to_f)
  end

  def radius
    object.radius.to_f
  end
end
