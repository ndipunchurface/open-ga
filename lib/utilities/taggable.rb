module Taggable
  def self.included(base)
    base.class_eval do
      has_many :taxonomies, :as => :taggable
      after_save :collect_hashtags
    end
  end

  def tags
    taxonomies.find(:all,:include => :tag).collect { |t| t.tag }
  end

  def tag_names
    taxonomies.find(:all,:include => :tag).collect { |t| t.tag.name }
  end

  def tag_with(name)
    tag = Tag.find_or_create_by_name(name)
    taxonomies.create(:tag_id => tag.id)
  end

  def untag_with(name)
    tag = Tag.find_last_by_name(name)
    taxonomies.find(:all, :conditions => ['tag_id = ?', tag.id]).each {|t| t.destroy}
  end

  def collect_hashtags
    #### reset all taxonomy
    tag_names.each {|t| untag_with(t)}

    columns_hash = ActiveRecord::Base.connection_pool.columns_hash[self.class.to_s.pluralize.downcase]
    columns_hash.each do |key,col|
      if columns_hash[key].type == :text
        string = eval key
        string.match(/#([a-zA-Z]+)/) do |m|
          tag_with(m[1])
        end
      end
    end
  end
end
