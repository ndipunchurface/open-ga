module Documentable
  def self.included(base)
    base.class_eval do
      has_many :documents, :as => :documentable
    end
  end
end
