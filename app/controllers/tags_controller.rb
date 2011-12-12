class TagsController < ApplicationController
  def show
    @tag = Tag.find_last_by_name(params[:id])

    # at the moment, only Proposals can be tagged, but I'm setting it up incase that needs to be changed
    # in the future
    @tagged_records = @tag.taxonomies.collect {|t| eval "#{t.taggable_type}.find(#{t.taggable_id})" }
  end
end
