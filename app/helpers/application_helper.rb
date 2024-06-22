module ApplicationHelper
  def flash_type(name)
    return 'info' if name == 'notice'
    return 'success' if name == 'notice'
    return 'error' if name == 'alert'
    name
  end
end
