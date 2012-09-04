class Person
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name,            type: String
  field :surname_father,  type: String
  field :searchable_name, type: String
  field :jurisdiction,    type: String
  field :force,           type: String
  field :tags,            type: Array
  field :confidence,      type: Float, default: 0.0

  before_save :store_normalize_name
  before_save :unify_tags

  has_and_belongs_to_many :documents
end
