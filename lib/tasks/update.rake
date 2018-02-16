require 'rubygems'
require 'gems'

namespace :update do 
  desc "It updates the ruby tools from the rubygems API"

  task tools: :environment do


    puts Gems.info("rails")["name"]

    def update_tool_attributes 
      #Loop through my tools
      tools = Tool.all
      tools.each do |tool|
        tool.update(
          #tool_category_id: #??? Is this something we get from the API or something we track ourselves?
          :name => Gems.info(tool.name)["name"],
          #slug: #friendly_url gem takes care of this
          :description => Gems.info(tool.name)["info"]
          #git_host: info["source_code_uri"] #Is this the same value just without the repo name at the end?
          #repo: info["source_code_uri"]
          :gem_name: Gems.info(tool.name)["name"]
          #last_commit_at: #Isn't this something we should get from the GitHub API?? Cant't find anything equivalent in the rubygems.org API
          #last_release_at: versions.first["created_at"]
          #score: info["version_downloads"] #curent version download number?? 
          #useful_links: ???
          #gorails_screencast_link: ???
        )
        puts "#{tool.errors.full_messages.join(",")}" if tool.errors.any?
        puts "#{tool.name} was updated"
      end
    end

    update_tool_attributes
  end

  task task2: :environment do
    puts 'task 2'
  end
end

