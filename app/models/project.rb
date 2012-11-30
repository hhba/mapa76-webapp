class Project
  include Mongoid::Document

  field :name, :type => String
  field :description, :type => String

  has_many :documents
  has_and_belongs_to_many :users
end
