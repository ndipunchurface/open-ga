class AddUpvoteToVotes < ActiveRecord::Migration
  def change
    add_column :votes, :upvote, :boolean
  end
end
