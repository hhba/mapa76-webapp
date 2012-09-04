class Document
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title,            type: String
  field :heading,          type: String
  field :category,         type: String
  field :published_at,     type: Date
  field :description,      type: String
  field :original_file,    type: String
  field :thumbnail_file,   type: String
  field :information,      type: Hash
  field :fontspecs,        type: Hash
  field :last_analysis_at, type: Time
  field :processed_text,   type: String
  field :state,            type: Symbol, default: :waiting

  has_and_belongs_to_many :people, index: true

  def readable?
    true
  end

  def has_geocoded_addresses?
    true
  end

  def processed?
    true
  end
end
