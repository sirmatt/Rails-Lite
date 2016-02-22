require 'active_support'
require 'active_support/core_ext'
require 'erb'
require_relative './session'


class ControllerBase
  attr_reader :req, :res, :params

  def initialize(req, res, route_params = {})
    @req, @res = req, res
    @params = route_params.merge(@req.params)

    @already_built_response = false
  end

  def already_built_response?
    @already_built_response
  end

  def check_if_response_was_rendered
    raise "you can't render twice!" if already_built_response?
  end

  def redirect_to(url)
    check_if_response_was_rendered

    @res.status = 302
    @res["Location"] = url

    @already_built_response = true

    session.store_session(@res)
  end

  def render_content(content, content_type)
    check_if_response_was_rendered

    @res.write(content)
    @res['Content-Type'] = content_type

    @already_built_response = true
    session.store_session(@res)
  end

  def render(template_name)
    directory_path = File.dirname(__FILE__)

    template_file_name = File.join(
      directory_path, "..",
      "views", self.class.name.underscore,
      "#{template_name}.html.erb"
    )

    template_code = File.read(template_file_name)

    render_content(
      ERB.new(template_code).result(binding),
      "text/html"
    )
  end

  def session
    @session ||= Session.new(@req)
  end

  def invoke_action(action_name)
    self.send(action_name)
    render(action_name) unless already_built_response?
  end
end
