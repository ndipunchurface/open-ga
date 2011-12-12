# The authorization class allows a user to register for
# an assembly using a valid registration number.
class Authorization < ActiveRecord::Base
  belongs_to :user
end
