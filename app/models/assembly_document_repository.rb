# This is a solution to deal with a polymorphic association
# on a model with a string (UUID) primary key
class AssemblyDocumentRepository < ActiveRecord::Base
  belongs_to :assembly, :foreign_key => :uuid

  include Documentable
end
