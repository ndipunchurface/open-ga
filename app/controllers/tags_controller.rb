class TagsController < ApplicationController
  def show
    @tag = Tag.find_last_by_name(params[:id])
    tagged_list = @tag.taxonomies.collect {|t| [t.taggable_id,t.taggable_type] }
    @tagged_records = Array.new

    tagged_list.each do |tagged|
      puts tagged.inspect 
    end
  end
end
