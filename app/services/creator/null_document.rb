module Creator
  class NullDocument
    def self.can_create?(document_params)
      true
    end

    def initialize(document_params)
    end

    def valid?
      false
    end

    def save
      false
    end
  end
end
