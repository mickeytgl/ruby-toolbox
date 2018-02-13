#README

    def info(gem_name)
      response = get("https://rubygems.org/api/v1/gems/#{gem_name}.json")
      JSON.parse(response)
    end

    def versions(gem_name)
      response = get("https://rubygems.org/api/v1/versions/#{gem_name}.json")
      JSON.parse(response)
    end

    def downloads(gem_name, gem_version)
      response = get("https://rubygems.org/api/v1/downloads/#{gem_name}-#{gem_version}")
      JSON.parse(response)
    end

    def update_tool_attributes 
      #Loop through my tools
      tools = Tool.all
      tools.each do |t|
      #for each tool, look it up on the API by name
        byebug
        update_info = info(t.name)
        version_info = versions(t.name)

      #update values from the API
        t.update(
          :tool_category_id => "Test id"#??? Is this something we get from the API or something e track ourselves?
          :name => info["name"]
          :slug => #friendly_url gem takes care of this
          :description => info["info"]
          :git_host => info["source_code_uri"] #Is this the same value just without the repo name t the end?
          :repo => info["source_code_uri"]
          :gem_name => info["name"]
          :last_commit_at => "Test last_commit_at"#Isn't this something we should get from the itHub API?? Cant't find anything equivalent in the rubygems.org API
          :last_release_at => versions.first["created_at"]
          :score => info["version_downloads"] #curent version download number?? 
          #:useful_links => ???
          #:gorails_screencast_link => ???
          )
      end