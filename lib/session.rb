require 'json'

class Session

  def initialize(req)
    cookie = req.cookies["_rails_lite_app"]
    if cookie
      @data = JSON.parse(cookie)
    else
      @data = {}
    end
  end

  def [](key)
    @data[key]
  end

  def []=(key, value)
    @data[key] = value
  end

  def store_session(res)
    cookie = { path: '/', value: @data.to_json }
    res.set_cookie("_rails_lite_app", cookie)
  end
end
