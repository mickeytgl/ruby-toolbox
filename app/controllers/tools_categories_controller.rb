class ToolsCategoriesController < ApplicationController

  def index
    @tool_category = ToolCategory.all
  end

  def show
    @tool_category = ToolCategory.friendly.find(params[:id])
  end
end
