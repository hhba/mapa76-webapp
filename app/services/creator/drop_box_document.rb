module Creator
  class DropBoxDocument
    def self.can_create?(document_params)
      document_params.has_key? :files
    end

    def initialize(document_params)
      @documents = []
      @document_params = document_params
      generate_documents
    end

    def generate_documents
      @documents = @document_params[:files].map do |file|
        download_file = FileDownloader.new file
        document = Document.new original_filename: download_file.filename
        document.original_filename = download_file.filename
        document
      end
    end

    def valid?
      @documents.all? { |document| document.valid? }
    end

    def save
      @documents.each { |document| document.save }
    end
  end
end
