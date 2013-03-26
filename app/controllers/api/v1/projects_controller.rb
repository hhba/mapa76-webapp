module Api
  module V1
    class ProjectsController < ApplicationController
      def show
        @project = Project.find params[:id]
      end

      def timeline
        @project = Project.find params[:id]
      end
    end
  end
end
