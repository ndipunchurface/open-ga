# A Block is instated by a user who feels the current
# proposal is highly dangerous, destructive, or against
# the principals of the Assembly. To give an example,
# a user proposes that an Occupation burn down the Capitol
# building and beat all of the Congressional representives.
# Obviously, being that Occupy is non-violent, this proposal
# would ideally be blocked by other users, in addition to
# being downvoted.
class Block < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
end
