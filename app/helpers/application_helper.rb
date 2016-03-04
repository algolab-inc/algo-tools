module ApplicationHelper
  def body_id
    [controller_name, action_name].join('-')
  end

  def current_tool
    @current_tool ||= Tool.find_by_key(controller_name)
  end
end
