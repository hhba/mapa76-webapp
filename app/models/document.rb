class Document
  include Mongoid::Document
  include Mongoid::Timestamps
  include Finder

  field :title,            type: String
  field :heading,          type: String
  field :category,         type: String
  field :published_at,     type: Date
  field :description,      type: String
  field :original_file,    type: String
  field :thumbnail_file,   type: String
  field :information,      type: Hash
  field :fontspecs,        type: Hash, default: {}
  field :last_analysis_at, type: Time
  field :processed_text,   type: String
  field :state,            type: Symbol, default: :waiting
  field :percentage,       type: Integer, default: 0

  has_many :pages
  has_many :registers
  has_many :named_entities
  has_and_belongs_to_many :people, index: true

  def self.status
    all.map { |document| document.status }
  end

  def status
    {
      :id => _id, :title => title, :category => category, :percentage => percentage,
      :readable => readable?, :geocoded => geocoded?, :exportable => exportable?, :completed => completed?,
      :generation_time => id.generation_time.strftime("%d/%m/%y"), :thumbnail => 'http://placekitten.com/g/70/90'
    }
  end

  def context
    {
      :id => id,
      :title => title,
      :registers => self.registers.map { |register| register.to_hash },
      :people => self.people.map { |person| { id: person.id, name: person.full_name, mentions: person.mentions_in(self) } },
      :dates => self.dates_found.group_by(&:text).map { |k, v| { text: k, mentions: v.size} },
      :organizations => self.organizations_found.group_by(&:text).map { |k, v| { text: k, mentions: v.size} },
      :places => (self.places_found + self.addresses_found).group_by(&:text).map { |k, v| { text: k, mentions: v.size} }
    }
  end

  def readable?
    true
  end

  def geocoded?
    true
  end

  def exportable?
    true
  end

  def processed?
    true
  end

  def completed?
    percentage == 100
  end
end
