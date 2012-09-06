class Register
  include Mongoid::Document
  include Mongoid::Timestamps

  field :who,    type: Array, default: []
  field :when,   type: Array, default: []
  field :where,  type: Array, default: []
  field :to_who, type: Array, default: []
  field :what,   type: String

  belongs_to :document, index: true

  def to_hash
    {
      who:    self.who.map { |w| NamedEntity.find(w).text },
      what:   self.what,
      when:   self.when.map { |w| NamedEntity.find(w).text },
      where:  self.where.map { |w| NamedEntity.find(w).text },
      to_who: self.to_who.map { |w| NamedEntity.find(w).text }
    }
  end
end
