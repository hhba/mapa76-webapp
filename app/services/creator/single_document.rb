module Creator
  class SingleDocument
    def self.can_create?(document_params)
      document_params.has_key? :file
    end

    def initialize(document_params)
      file = document_params.delete(:file)
      @document = Document.new document_params
      if file
        @document.original_filename = file.original_filename
        @document.file = file.path
      end
    end

    def valid?
      @document.valid?
    end

    def save
      @document.save
    end
  end
end
