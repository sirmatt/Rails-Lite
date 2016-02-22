class Route
  attr_reader :pattern, :http_method, :controller_class, :action_name

  def initialize(pattern, http_method, controller_class, action_name)
    @pattern, @http_method = pattern, http_method
    @controller_class, @action_name = controller_class, action_name
  end

  def matches?(req)
    @http_method ==
    (req.request_method.downcase.to_sym) &&
    (@pattern =~ req.path)
  end

  def run(req, res)
    match_data = @pattern.match(req.path)

    route_params = Hash[match_data.names.zip(match_data.captures)]

    @controller_class
      .new(req, res, route_params)
      .invoke_action(@action_name)
  end
end


class Router
  attr_reader :routes

  def initialize
    @routes = []
  end

  def add_route(pattern, method, controller_class, action_name)
    @routes << Route.new(
      pattern,
      method,
      controller_class,
      action_name
    )
  end

  # Self, at this point, is the Router object. We call instance_eval on that Router which says "hey, whatever code I send you in a block, evaluate it in terms of this Router object."

  # In the server file, we send it two methods that the Router needs to evaluate:
  # get(Regexp.new)
  def draw(&proc)
    self.instance_eval(&proc)
  end

  # make each of these methods that
  # when called add route
  [:get, :post, :put, :delete].each do |http_method|
    define_method(http_method) do |pattern, controller_class, action_name|
      add_route(pattern, http_method, controller_class, action_name)
    end
  end

  def match(req)
    @routes.find { |route| route.matches?(req) }
  end

  def run(req, res)
    matching_route = match(req)

    if matching_route.nil?
      res.status = 404
    else
      matching_route.run(req, res)
    end
  end
end
