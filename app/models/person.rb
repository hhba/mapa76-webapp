class Person
  def metainfo
    docs = documents.map { |doc| { id: doc._id, name: doc.heading } }

    { _id: _id,
      created_at: created_at,
      documents: docs,
      full_name: full_name,
      tags: tags }
  end
end
