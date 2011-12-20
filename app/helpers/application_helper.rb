module ApplicationHelper
  def title(title, print = true)
    content_for :title, title
    "<h2>#{title}</h2>".html_safe if print
  end

  def link_tags(string)
    string.gsub(/#[a-zA-Z]+/) do |m|
      link_to m, :controller => 'tags', :action => 'show', :id => m.sub(/#/,'')
    end
  end

  def snippet(thought, wordcount)
    clean_tags(thought).split[0..(wordcount-1)].join(" ") +(thought.split.size > wordcount ? "\u2026" : "")
  end 
  
  def clean_tags(string)
    string.gsub(/#[a-zA-Z]+/,'')
  end
end
