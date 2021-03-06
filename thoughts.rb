def update_tool_attributes 
  #Loop through my tools
  tools = Tool.all
  tools.each do |t|
  #for each tool, look it up on the API by name
    update_info = info(t.name)
    version_info = versions(t.name)

  #update values from the API
    t.update(
      tool_category_id: #??? Is this something we get from the API or something we track ourselves?
      name: info["name"]
      slug: #friendly_url gem takes care of this
      description: info["info"]
      git_host: info["source_code_uri"] #Is this the same value just without the repo name at the end?
      repo: info["source_code_uri"]
      gem_name: info["name"]
      last_commit_at: #Isn't this something we should get from the GitHub API?? Cant't find anything equivalent in the rubygems.org API
      last_release_at: versions.first["created_at"]
      score: info["version_downloads"] #curent version download number?? 
      #useful_links: ???
      #gorails_screencast_link: ???
      )
  end
end