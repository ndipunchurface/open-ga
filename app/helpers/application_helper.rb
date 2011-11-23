module ApplicationHelper
  def title(title)
    content_for :title, title
    "<h2>#{title}</h2>".html_safe
  end
end
