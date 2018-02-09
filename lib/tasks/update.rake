namespace :update do 
  desc "It updates the ruby tools from the rubygems API"

  task tools: :environment do 

  def update_tool_attributes 
  #Loop through my tools
  tools = Tool.all
  tools.each do |t|
  #for each tool, look it up on the API by name
    update_info = Gems.info(t.name)
    version_info = Gems.versions(t.name)

  #update values from the API
    t.update(
      description: update_info["info"]
      score: update_info["downloads"]
      updated_at: version_info.first
      )
  end
  end
end