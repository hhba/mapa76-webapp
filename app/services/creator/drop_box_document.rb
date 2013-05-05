module Creator
  class DropBoxDocument
    def self.can_create?(document_params)
      document_params.has_key? :files
    end

    def initialize(document_params)
      @document_params = document_params
    end

    def document_links
      @document_params[:files]
    end

    def valid?
      true
    end

    def save
      Resque.enqueue(DropBoxCreatorTask, document_links)
    end
  end
end
