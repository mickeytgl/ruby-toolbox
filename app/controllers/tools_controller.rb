class ToolsController < ApplicationController

  def index
    @tools = Tool.all
  end

  def show
    @tool = Tool.friendly.find(params[:id])
  end

  def import 
    Tool.import(params[:file])
    redirect_to root_url, notice: "Tools imported!"
  end
end
