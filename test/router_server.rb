require 'rack'
require_relative '../lib/controller_base'
require_relative '../lib/router'

$ninja_turtles = [
  { id: 1, name: "Rafael", weapon: "sai blades" },
  { id: 2, name: "Donatello", weapon: "the bo Staff" },
  { id: 3, name: "Michelangelo", weapon: "nunchaku" },
  { id: 4, name: "Leonardo", weapon: "twin katanas"  }
]

$fav_toppings = [
  { id: 1, turtle_id: 1, favorite: "Rafael likes pepperoni!" },
  { id: 2, turtle_id: 2, favorite: "Donatello prefers combination!" },
  { id: 3, turtle_id: 1, favorite: "Rafael also digs cheese!" }
]

class ToppingsController < ControllerBase
  def index
    toppings = $fav_toppings.select do |topping|
      topping[:turtle_id] == Integer(params['turtle_id'])
    end

    render_content(toppings.to_json, "application/json")
  end
end

class TurtlesController < ControllerBase
  def index
    render_content($ninja_turtles.to_json, "application/json")
  end
end

class HomeController < ControllerBase
  def index
    render :index
  end
end

router = Router.new
router.draw do
  get Regexp.new("^/$"), HomeController, :index
  get Regexp.new("^/turtles$"), TurtlesController, :index
  get Regexp.new("^/turtles/(?<turtle_id>\\d+)/fav_toppings$"), ToppingsController, :index
end

app = Proc.new do |env|
  req = Rack::Request.new(env)
  res = Rack::Response.new
  router.run(req, res)
  res.finish
end

Rack::Server.start(
 app: app,
 Port: 3000
)
