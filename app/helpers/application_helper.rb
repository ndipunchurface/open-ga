module ApplicationHelper
  def title(title, print = true)
    content_for :title, title
    "<h2>#{title}</h2>".html_safe if print
  end
end
