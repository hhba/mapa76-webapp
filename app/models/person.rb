class Person
  # FIXME this should be a helper
  def metainfo
    docs = self.documents.map { |doc| {id: doc._id, name: doc.heading }}
    {"_id" => _id, "created_at" => created_at, :documents => docs, :full_name => full_name, :tags => tags}
  end
end
