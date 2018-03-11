require 'rubygems'
require 'gems'

namespace :update do 
  desc "It updates the ruby tools from the rubygems API"
  task tools: :environment do

    def update_tool_attributes 
      updated = 0
      Tool.find_each do |tool|
        next if tool.gem_name.nil?

        puts "\nUpdating #{tool.gem_name}"
        tool_gem    = Gems.info(tool.name)
        gem_version = Gems.versions(tool.name)

        tool.update(
          name:            tool_gem["name"],
          description:     tool_gem["info"],
          git_host:        "github"  ,
          repo:            tool_gem["source_code_uri"],
          gem_name:        tool_gem["name"],
          last_release_at: gem_version.first["created_at"]
          last_commit_at:  find_ast_commit("github", tool_gem["source_code_uri"])
        )

        if tools.errors.any?
          puts "#{tool.name} failed to update: #{tool.errors.full_messages.join(",")}"
        else
          puts "#{tool.name} was updated"
          updated += 1
        end
      end

      puts "#{updated} tools were updated"
    end

    update_tool_attributes
  end

end

  private

    def find_last_commit(git_host, uri)
      return nil if url.blank?
      send("find_last_commit_#{git_host}", url)
    end

    def find_last_commit_github(url)
      puts url
      author, repo = get_author_and_repo_name(url)
      Github.new.repos.commits.list(author, repo).first["commit"]["committer"]["date"]
    rescue Github::Error::NotFound
      puts "#{url} was not found"
      nil
    end

    def get_author_and_repo_name(url)
      url.split("/").last(2)
    end
