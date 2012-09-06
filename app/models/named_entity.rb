class NamedEntity
  include Mongoid::Document

  field :text,      :type => String, :default => lambda { human_form }
  field :pos,       :type => Integer
  field :inner_pos, :type => Hash

  field :ne_class, :type => Symbol, :default => lambda { tag ? CLASSES_PER_TAG[tag] : nil }

  field :form,     :type => String
  field :lemma,    :type => String
  field :tag,      :type => String
  field :prob,     :type => Float
  field :tokens,   :type => Array

  belongs_to :document, index: true
  belongs_to :person, index: true
  belongs_to :blacklist, index: true

private

  def human_form
    form.gsub('_', ' ') if form
  end
end
