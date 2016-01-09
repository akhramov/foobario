class HomeController < ApplicationController
  def index
    serialize = ->(u) { UserSerializer.new(u) }
    gon.push(cells: User.all.map(&serialize) , my_id: cookies.signed[:user_id])
  end
end
