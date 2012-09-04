class WelcomeController < ApplicationController
  def index
    @documents = Document.limit(5)
  end
end
