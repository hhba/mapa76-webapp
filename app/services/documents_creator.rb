class DocumentsCreator
  STRATEGIES = %w(SingleDocument DropBoxDocument NullDocument)
  def initialize(document_params)
    @document_params = document_params
    @strategy = pick_strategy
  end

  def pick_strategy
    strategy_klass = STRATEGIES.find { |klass| creator(klass).can_create?(@document_params) }
    creator(strategy_klass).new @document_params
  end

  def valid?
    @strategy.valid?
  end

  def save
    @strategy.save
  end

  def creator(klass)
    "Creator::#{klass}".constantize
  end
end
