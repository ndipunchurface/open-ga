module ApplicationHelper
  def title(title, print = true)
    content_for :title, title
    "<h2>#{title}</h2>".html_safe if print
  end

  def link_tags(string)
    string.gsub(/#([a-zA-Z]+)/) do |m|
      link_to m[0], :controller => 'tags', :action => 'show', :id => m[1]
    end
  end
end
