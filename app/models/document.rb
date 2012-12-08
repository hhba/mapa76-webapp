class Document
  include Mongoid::Pagination

  after_create :enqueue_process


  include Tire::Model::Search
  include Tire::Model::Callbacks

  tire do
    mapping do
      indexes :title,   analyzer: "snowball", boost: 100
      indexes :heading, analyzer: "snowball", boost: 100
      indexes :pages,   analyzer: "snowball"
    end
  end


  # FIXME this should be a helper
  def context
    {
      :id => id,
      :title => title,
      :registers => self.fact_registers.map(&:to_hash),
      :people => self.people.map { |person| { id: person.id, name: person.full_name, mentions: person.mentions_in(self) } },
      :dates => self.dates_found.group_by(&:text).map { |k, v| { text: k, mentions: v.size} },
      :organizations => self.organizations_found.group_by(&:text).map { |k, v| { text: k, mentions: v.size} },
      :places => (self.places_found + self.addresses_found).group_by(&:text).map { |k, v| { text: k, mentions: v.size} }
    }
  end

  def to_indexed_json
    fields = {
      title: title,
      heading: heading,
      pages: {},
    }
    pages.each do |page|
      fields[:pages][page.num] = page.text.gsub(/<[^<]+?>/, "")
    end
    fields.to_json
  end

protected
  def enqueue_process
    # TODO Create empty class NormalizationTask
    #Resque.enqueue(NormalizationTask, id)
    return true
  end
end
