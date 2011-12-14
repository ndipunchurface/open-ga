class AssemblyCategory < ActiveRecord::Base
  belongs_to :assembly, :foreign_key => :uuid
end
