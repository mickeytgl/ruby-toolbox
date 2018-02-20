require 'rubygems'
require 'gems'

namespace :update do 
  desc "It updates the ruby tools from the rubygems API"

  task tools: :environment do

    def update_tool_attributes 
      #Loop through my tools
      counter = 0
      tools = Tool.all
      tools.each do |tool|
        @tool_url = tool.repo
        tool.update(
          :name => Gems.info(tool.name)["name"],
          #slug: #friendly_url gem takes care of this
          :description => Gems.info(tool.name)["info"],
          :git_host => "github"  ,
          :repo => Gems.info(tool.name)["source_code_uri"],
          :gem_name => Gems.info(tool.name)["name"],
          :last_commit_at => find_last_commit(tool.git_host),
          :last_release_at => Gems.versions(tool.name).first["created_at"]
          #score: Manually inserted
          #useful_links: ???
          #gorails_screencast_link: ???
        )
        puts "#{tool.errors.full_messages.join(",")}" if tool.errors.any?
        puts "#{tool.name} was updated"
        counter += 1
      end
      puts "#{counter} tools were updated"
    end

    update_tool_attributes
  end

end

  private

    def find_last_commit(git_host)
      send("find_last_commit_#{git_host}")
    end

    def find_last_commit_github(author = get_author_name(@tool_url), repo = get_repo_name(@tool_url))
      github = Github.new 
      github.repos.commits.list(author, repo).first["commit"]["committer"]["date"]
    end

    def get_author_name(url)
      trimmed_url = url.scan(/github\.com.*/).first.split("/")
      return trimmed_url[1]
    end

    def get_repo_name(url)
      trimmed_url = url.scan(/github\.com.*/).first.split("/")
      return trimmed_url[2]
    end
