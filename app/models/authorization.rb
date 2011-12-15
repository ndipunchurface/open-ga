# The authorization class allows a user to register for
# an assembly using a valid registration number.
class Authorization < ActiveRecord::Base
  belongs_to :user

  def self.num_admins(assembly)
    if assembly.class.to_s =~ /String/i
      where(:assembly_uuid => assembly).where('role >= ?', 1).count
    else
      where(:assembly_uuid => assembly.uuid).where('role >= ?', 1).count
    end
  end
end
