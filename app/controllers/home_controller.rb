class HomeController < ApplicationController
  def index
    @tool_categories = ToolCategory.all
  end
end
