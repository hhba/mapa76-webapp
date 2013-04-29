module Creator
  class DropBoxDocument
    def self.can_create?(document_params)
      document_params.has_key? :files
    end

    def initialize(document_params)
      @document_params = document_params
    end

    def valid?
    end

    def save
    end
  end
end
